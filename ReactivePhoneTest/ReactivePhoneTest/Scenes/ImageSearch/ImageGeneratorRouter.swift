import UIKit
import Foundation

protocol ImageGeneratorLogic {
    func start()
}

final class ImageGeneratorRouter: ImageGeneratorLogic {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ImageGeneratorViewController(nibName: nil, bundle: nil)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
