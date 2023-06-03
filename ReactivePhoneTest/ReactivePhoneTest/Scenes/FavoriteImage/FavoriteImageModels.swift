
import Foundation

struct FavoriteImagesModels {
    
    enum GetData {
        struct Response {
            let data: [ImageEntity]
        }
        
        struct ViewModel {
            let images: [ImageResponse]
        }
    }
    
    enum DeleteImage {
        struct Request {
            let image: ImageResponse
        }
    }
    
}
