import Foundation
import UIKit

final class Application {
    
    static let shared = Application()
    
    func configureMainInterface(in window: UIWindow) {
        updateApperance()
        
        //Image Generator section
        let imageGeneratorNavController = UINavigationController()
        imageGeneratorNavController.navigationBar.isHidden = true
        imageGeneratorNavController.tabBarItem = UITabBarItem(title: "Main",
                                                              image: .photo,
                                                              selectedImage: .photoFill)
        let imageGeneratorRouter = ImageGeneratorRouter(navigationController: imageGeneratorNavController)
        
        //Favorite images section
        let favoriteImagesNavController = UINavigationController()
        favoriteImagesNavController.navigationBar.isHidden = true
        favoriteImagesNavController.tabBarItem = UITabBarItem(title: "Favorite",
                                                              image: .heart,
                                                              selectedImage: .heartFill)
        let favoriteImagesRouter = FavoriteImageRouter(navigationController: favoriteImagesNavController)
        
        //Tab bar
        let tabBar = UITabBarController()
        
        tabBar.viewControllers = [imageGeneratorNavController, favoriteImagesNavController]
        
        window.rootViewController = tabBar
        
        imageGeneratorRouter.start()
        favoriteImagesRouter.start()
    }
    
    private func updateApperance() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = .gray
        tabBarAppearance.unselectedItemTintColor = .lightGray
    }
}
