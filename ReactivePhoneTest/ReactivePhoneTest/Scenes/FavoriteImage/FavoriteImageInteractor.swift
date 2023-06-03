
import Foundation

protocol FavoriteImageBusinessLogic {
    func getData()
    func deleteImage(_ request: FavoriteImagesModels.DeleteImage.Request)
}

final class FavoriteImageInteractor: FavoriteImageBusinessLogic {
    
    var presenter: FavoriteImagePresentationLogic?
    
    private let coreDataWorker = CoreDataWorker()
    
    func getData() {
        let response = FavoriteImagesModels.GetData.Response(data: coreDataWorker.getImages())
        presenter?.presentData(response)
    }
    
    func deleteImage(_ request: FavoriteImagesModels.DeleteImage.Request) {
        coreDataWorker.deleteImage(request.image)
    }
}
