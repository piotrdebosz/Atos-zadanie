@testable import Atos
import Foundation

extension Article {
    static var dummy: Article {
        Article(
            author: "Dummy Author",
            title: "Dummy Title",
            description: "Dummy Description",
            urlToImage: nil,
            publishedAt: "2023-01-01T00:00:00Z"
        )
    }
}
