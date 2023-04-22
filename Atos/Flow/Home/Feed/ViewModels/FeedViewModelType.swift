import Foundation

protocol FeedViewModelType: AnyObject {
    var delegate: FeedViewModelDelegate? { get set }
    var coordinatorDelegate: FeedCoordinatorDelegate? { get set }

    var userName: String { get }

    func viewDidLoad()
    func scrolledToTheBottom()
    func refreshDataInitiatedByUser()
    func userSelectedArticle(at index: Int)
}
