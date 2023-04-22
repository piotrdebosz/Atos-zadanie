import Foundation

struct ArticleListCellViewModel: ArticleListCellViewModelType {
    // TODO: change variable name

    private let tempAuthor: String?
    let title: String

    init(author: String?, title: String) {
        tempAuthor = author
        self.title = title
    }

    // TODO: refactor
    var author: String {
        if let author = tempAuthor, !author.isEmpty {
            return author
        }

        return "Anonim"
    }
}
