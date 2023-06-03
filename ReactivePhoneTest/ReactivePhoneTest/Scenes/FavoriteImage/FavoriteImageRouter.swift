import UIKit
import Foundation

protocol FavoriteImagerRoutingLogic {
    func start()
}

final class FavoriteImageRouter: FavoriteImagerRoutingLogic {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FavoriteImageViewController(nibName: nil, bundle: nil)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
