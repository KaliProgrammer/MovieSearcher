

import Foundation

struct MoviesListCellModel {
    let imageURL: URL?
    let title: String?
    let summary: String?
    let rating: Double
    let year: Int

    init(docModel model: Doc) {
        if let imageString = model.poster?.url, let url = URL(string: imageString) {
            self.imageURL = url
        } else {
            self.imageURL = nil
        }
        self.title = model.name
        self.summary = model.shortDescription
        if let rating = model.rating?.kp {
            self.rating = Double(round(10 * rating)/10)
        } else {
            self.rating = 0
        }
        self.year = model.year ?? 0
    }
}
