import Foundation
import UIKit

enum ImageGeneratorModels {
    
    enum LoadImage {
        
        struct Reguest {
            let text: String
        }
        
        struct Response {
            let imageData: Data
        }
        
        struct ViewModel {
            let  image: UIImage
        }
    }
    
    enum AddToFavorite {
        struct Reguest {
            let requestText: String
            let data: Data
        }
        
        struct Response {
            let imageData: Data
        }
        
        struct ViewModel {
            let image: UIImage
        }
    }
    
    enum PresentError {
        struct Response {
            let error: Error
        }
        
        struct ViewModel {
            let errorText: String
        }
    }
}
