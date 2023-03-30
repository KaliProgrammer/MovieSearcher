

import UIKit

extension CollectionViewCell: CollectionViewCellProtocolForHomeVC {
    func apply(image: String) {
        let url = URL(string: image)
        movieImageView.load(url: url!)
    }

    func apply(title: String) {
        movieTitleLabel.text = title
    }

    func apply(summary: String) {
        summaryLabel.text = summary
    }

    func apply(rating: Double) {
        ratingLabel.text = String(describing:"⭐️ \(rating)")
    }

    func apply(year: Int) {
        yearLabel.text = String(describing: year)
    }
}
