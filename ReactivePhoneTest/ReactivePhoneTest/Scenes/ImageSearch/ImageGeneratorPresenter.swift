import UIKit
import Foundation

protocol ImageGeneratorPresentationLogic {
    func presentImage(_ response: ImageGeneratorModels.LoadImage.Response)
    func presentError(_ error: ImageGeneratorModels.PresentError.Response)
}

final class ImageGeneratorPresenter: ImageGeneratorPresentationLogic {
    
    weak var viewController: ImageGeneratorDisplayLogic?
    
    func presentImage(_ response: ImageGeneratorModels.LoadImage.Response) {
        guard let image = UIImage(data: response.imageData) else { return }
        viewController?.displayImage(ImageGeneratorModels.LoadImage.ViewModel(image: image))
    }
    
    func presentError(_ response: ImageGeneratorModels.PresentError.Response) {
        viewController?.displayError(ImageGeneratorModels.PresentError.ViewModel(errorText: response.error.localizedDescription))
    }
}
