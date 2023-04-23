import Foundation

protocol NewsListViewModelType: AnyObject {
    var delegate: NewsListViewModelDelegate? { get set }
    var coordinatorDelegate: NewsListViewModelCoordinatorDelegate? { get set }

    var isLoading: Bool { get }

    var userName: String { get }
    var numberOfItems: Int { get }

    func newsItem(at index: Int) -> NewsListCellDataItem

    func viewDidLoad()
    func scrolledToTheBottom()
    func refreshDataInitiatedByUser()
    func userSelectedArticle(at index: Int)
}
