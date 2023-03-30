
import Foundation

protocol NetworkLayer {
    func getAllMovies(callback: @escaping (MoviesResult) -> Void)
}
