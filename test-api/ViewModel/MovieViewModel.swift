

import Foundation
import UIKit

protocol ApplyDescriptionProtocol {
    func loadImage(image: String, from view: MovieView)
    func apply(textDescription: String, from view: MovieView)
    func apply(movieName: String, from view: MovieView)
}

class MovieViewModel: ApplyDescriptionProtocol {
    
    var contentView = MovieView()

    func loadImage(image: String, from view: MovieView) {
        let url = URL(string: image)
        view.movieImage.load(url: url!)
    }

    func apply(textDescription: String, from view: MovieView) {
        view.movieDescriptionLabel.text = textDescription
    }
    
    func apply(movieName: String, from view: MovieView) {
        view.movieNameLabel.text = movieName
    }
    
    func apply(movieRating: Double, from view: MovieView) {
        view.movieRatingLabel.text = String(describing: "⭐️ \(movieRating)")
    }

    func apply(movieYear: Int, from view: MovieView) {
        view.movieYearLabel.text = String(describing: movieYear)
    }
    
}
