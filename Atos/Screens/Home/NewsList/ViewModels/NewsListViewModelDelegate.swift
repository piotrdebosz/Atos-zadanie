import Foundation

protocol NewsListViewModelDelegate: AnyObject {
    func didLoadArticles()
    func didFailToLoadArticles(error: Error)
    func didChangeLoadingState()
}
