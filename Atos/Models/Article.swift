import Foundation

struct Article: Codable {
    let author: String?
    let title: String
    let description: String?
    let urlToImage: String?
    let publishedAt: String
}
