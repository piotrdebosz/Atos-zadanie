import Foundation

protocol NewsListViewModelCoordinatorDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}
