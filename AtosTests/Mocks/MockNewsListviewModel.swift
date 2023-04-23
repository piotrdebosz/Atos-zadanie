import Foundation
@testable import Atos

class MockNewsListViewModel: NewsListViewModelType {
    weak var delegate: NewsListViewModelDelegate?
    weak var coordinatorDelegate: NewsListViewModelCoordinatorDelegate?

    var isLoading: Bool = false
    var userName: String = ""
    var numberOfItems: Int = 0

    var viewDidLoadCalled = false
    var scrolledToTheBottomCalled = false
    var refreshDataInitiatedByUserCalled = false
    var userSelectedArticleCalled = false

    func newsItem(at index: Int) -> NewsListCellDataItem {
        return NewsListCellDataItem(author: "Mock Author", title: "Mock Title")
    }

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func scrolledToTheBottom() {
        scrolledToTheBottomCalled = true
    }

    func refreshDataInitiatedByUser() {
        refreshDataInitiatedByUserCalled = true
    }

    func userSelectedArticle(at index: Int) {
        userSelectedArticleCalled = true
    }
}
