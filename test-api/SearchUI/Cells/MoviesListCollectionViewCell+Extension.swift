

import UIKit
import Kingfisher

extension MoviesListCollectionViewCell: CollectionViewCellProtocol {

    func configure(withModel model: MoviesListCellModel) {
        if let url = model.imageURL {
            movieImageView.kf.setImage(with: url)
        }
        movieTitleLabel.text = model.title
        summaryLabel.text = model.summary
        if model.summary == nil {
            summaryLabel.text = "Описание отсуствует"
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        let ratingString = numberFormatter.string(from: model.rating as NSNumber) ?? "0"
        ratingLabel.text = String(describing:"⭐️ \(ratingString)")
        let yearString = numberFormatter.string(from: model.year as NSNumber) ?? "0"
        yearLabel.text = yearString
    }
}
