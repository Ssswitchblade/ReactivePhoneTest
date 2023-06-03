
import Foundation

enum NetworkRequestError: Error {
    case unknown(Data?, URLResponse?)
    case incorrectURL
}

struct ImageNetworkWorker {
    
    private let endPoint = "https://dummyimage.com/250x250&text="
    
    func getImageData(_ path: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: endPoint + path) else {
            completion(.failure(NetworkRequestError.incorrectURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkRequestError.unknown(data, response)))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
}
