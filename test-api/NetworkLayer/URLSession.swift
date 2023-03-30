

import Foundation

class URLSessionLayer: NetworkLayer {
   
    private let baseAddressForMovies = "https://api.kinopoisk.dev/v1/movie?random"
    
    init() {}
    
    func getAllMovies(callback: @escaping (MoviesResult) -> Void) {
        
        if let url = URL(string: baseAddressForMovies) {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
                "X-API-Key": "MFQ8GKZ-7TS4W7J-NZ1CVE9-5MKJ9MW"
            ]
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else { return }
                do {
                    let decoder = try JSONDecoder().decode(Movies.self, from: data)
                    callback(Result.success(decoder))
                } catch {
                    callback(Result.failure(.wrongJson("Wrong format")))
                }
            }.resume()
        }
    }
    
  
    
    
}
