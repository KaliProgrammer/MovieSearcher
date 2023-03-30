
import Foundation

final class SearchRequestComponentsBuilder {
    static func buildComponents(fromRequest request: SearchRequest) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if let page = request.page {
            let pageItem = URLQueryItem(name: "page", value: page)
            queryItems.append(pageItem)
        }

        if let name = request.info.name {
            let nameItem = URLQueryItem(name: "name", value: name)
            queryItems.append(nameItem)
        }

        if let genre = request.info.genre {
            let genreItem = URLQueryItem(name: "genres.name", value: genre)
            queryItems.append(genreItem)
        }

        if let actor = request.info.actor {
            let paramName: String
            if actor.latinCharactersOnly {
                paramName = "persons.enName"
            } else {
                paramName = "persons.name"
            }
            let actorItem = URLQueryItem(name: paramName, value: actor)
            queryItems.append(actorItem)
        }
        return queryItems
    }
}
