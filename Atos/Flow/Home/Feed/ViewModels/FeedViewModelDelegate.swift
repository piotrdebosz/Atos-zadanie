import Foundation

protocol FeedViewModelDelegate: AnyObject {
    func loadedArticles(articles: [ArticleListCellViewModelType])
    func failedToLoadArticles(error: Error)
    func didChangeLoadingState(isLoading: Bool)
}
