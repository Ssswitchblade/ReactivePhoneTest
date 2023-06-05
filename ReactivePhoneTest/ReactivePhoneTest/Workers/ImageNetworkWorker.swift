
import Foundation

enum NetworkRequestError: Error {
    case unknown(Data?, URLResponse?)
    case incorrectURL
}

final class ImageNetworkWorker {
    
    private let endPoint = "https://dummyimage.com/250x250&text="
    lazy var configuration: URLSessionConfiguration = {
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return configuration
    }()
    lazy var session = URLSession(configuration: configuration)
    func getImageData(_ path: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: endPoint + path) else {
            completion(.failure(NetworkRequestError.incorrectURL))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let responseCast = response as? HTTPURLResponse  {
                if responseCast.statusCode != 200 {
                    completion(.failure("Status code != 200"))
                }
                
            } else {
                completion(.failure("Reponse == nil"))
            }
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkRequestError.unknown(data, response)))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
}

extension String: Error {
    
}
