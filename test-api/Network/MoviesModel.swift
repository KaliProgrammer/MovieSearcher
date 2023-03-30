
import Foundation

// MARK: - Movies

struct Movies: Codable {
    var docs: [Doc]?
    let total, limit, page, pages: Int?
}

// MARK: - Doc
struct Doc: Codable {
    let externalID: ExternalID?
    let rating, votes: Rating?
    let movieLength, id: Int?
    let type: TypeEnum?
    let name, description: String?
    let year: Int?
    let poster: Poster?
    let alternativeName: String?
    let enName: JSONNull?
    let names: [Name]?
    let shortDescription: String?
    let logo: Logo?
    let watchability: Watchability?
    let color: String?

    enum CodingKeys: String, CodingKey {
        case externalID = "externalId"
        case rating, votes, movieLength, id, type, name, description, year, poster, alternativeName, enName, names, shortDescription, logo, watchability, color
    }
}

// MARK: - ExternalID
struct ExternalID: Codable {
    let kpHD, imdb: String?
    let tmdb: Int?
}

// MARK: - Logo
struct Logo: Codable {
    let url: String?
}

// MARK: - Name
struct Name: Codable {
    let name: String?
}

// MARK: - Poster
struct Poster: Codable {
    let url, previewURL: String?

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL = "previewUrl"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let kp, imdb, filmCritics, russianFilmCritics: Double?
    let ratingAwait: Double?

    enum CodingKeys: String, CodingKey {
        case kp, imdb, filmCritics, russianFilmCritics
        case ratingAwait = "await"
    }
}

enum TypeEnum: String, Codable {
    case cartoon
    case movie
    case tvSeries = "tv-series"
    case anime
    case animatedSeries = "animated-series"
    case tvShow = "tv-show"
}

// MARK: - Watchability
struct Watchability: Codable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let name: String?
    let logo: Logo?
    let url: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
