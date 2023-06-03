
import Foundation

protocol FavoriteImagePresentationLogic {
    func presentData(_ data: FavoriteImagesModels.GetData.Response)
}

final class FavoriteImagePresenter: FavoriteImagePresentationLogic {
    
    weak var viewController: FavoriteImageDisplayLogic?
    
    func presentData(_ response: FavoriteImagesModels.GetData.Response) {
        let images: [ImageResponse] = response.data.map { .init(text: $0.request, data: $0.image) }
        viewController?.displayImages(FavoriteImagesModels.GetData.ViewModel(images: images))
    }
}
