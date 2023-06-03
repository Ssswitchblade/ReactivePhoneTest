
import Foundation

protocol ImageGeneratorBusinessLogic {
    func getImage(_ reguest: ImageGeneratorModels.LoadImage.Reguest)
    func addToFavorite()
    func getAllImages()
}

final class ImageGeneratorInteractor: ImageGeneratorBusinessLogic {
    
    var presenter: ImageGeneratorPresentationLogic?
    
    private let imageNetworkWorker = ImageNetworkWorker()
    
    private let getImageWorker = ImageNetworkWorker()
    
    private let coreDataWorker = CoreDataWorker()
    
    private var lastImage: ImageResponse?
    
    private var imageRequests: [ImageResponse] = []
    private var imagesCoreData: [ImageResponse] = []
    
    func getImage(_ reguest: ImageGeneratorModels.LoadImage.Reguest) {
        
        for image in imageRequests {
            if image.text == reguest.text {
                self.presenter?.presentImage(ImageGeneratorModels.LoadImage.Response(imageData: image.data))
                return
            }
        }
        
        getImageWorker.getImageData(reguest.text) { [weak self] result in
            switch result {
            case .success(let data):
                let response = ImageGeneratorModels.LoadImage.Response(imageData: data)
                self?.lastImage = ImageResponse(text: reguest.text, data: data)
                self?.imageRequests.append(ImageResponse(text: reguest.text, data: data))
                self?.presenter?.presentImage(response)
            case .failure(let error):
                self?.presenter?.presentError(ImageGeneratorModels.PresentError.Response(error: error))
            }
        }
    }
    
    func addToFavorite() {
        guard let lastImage else { return }
        for image in imagesCoreData {
            if image.text == lastImage.text {
                return
            }
        }
        imagesCoreData.append(lastImage)
        coreDataWorker.saveImage(data: lastImage.data, request: lastImage.text)
    }
    
    func getAllImages() {
        let entites = coreDataWorker.getImages()
        imagesCoreData = entites.map { .init(text: $0.request, data: $0.image) }
        imageRequests = imagesCoreData
    }
}
