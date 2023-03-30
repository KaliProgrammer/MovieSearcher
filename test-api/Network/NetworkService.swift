
import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case custom(String)
    case emptyData
    case wrongJson(String)
    case wrongURL
    case wrongParameters

    var description: String {
        switch self {
        case .custom(let text):
            return text
        case .emptyData:
            return "empty data"
        case .wrongJson(let json):
            return "wrong json - \(json)"
        case .wrongURL:
            return "wrong URL"
        case .wrongParameters:
            return "wrong params"
        }
    }
}

protocol NetworkService {
    func getMovies(searchRequest: SearchRequest, callback: @escaping (Result<Movies, NetworkError>) -> ())
}

final class NetworkServiceImpl: NetworkService {

    private var baseURL: String {
        return "https://api.kinopoisk.dev/v1"
    }

    private var defaultHeaders: [String : String]? {
        return ["X-API-Key": "MFQ8GKZ-7TS4W7J-NZ1CVE9-5MKJ9MW"]
    }

    func getMovies(searchRequest: SearchRequest, callback: @escaping (Result<Movies, NetworkError>) -> ()) {
        let requestPathAddtion = "/movie"
        guard var urlComponents = URLComponents(string: baseURL + requestPathAddtion) else {
            callback(.failure(.wrongParameters))
            return
        }
        let queryItems = SearchRequestComponentsBuilder.buildComponents(fromRequest: searchRequest)
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            callback(.failure(.wrongURL))
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        let task = URLSession.shared.dataTask(with: request) { data, response, erorr in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Movies.self, from: data)
                    callback(.success(result))
                } catch {
                    callback(.failure(.wrongJson(String(data: data, encoding: .utf8) ?? "unknown JSON or empty data")))
                    print(error)
                }
            }
        }
        task.resume()
    }
}
