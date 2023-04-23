import XCTest
@testable import Atos

class NewsCoordinatorTests: XCTestCase {
    private var navigationController: UINavigationController!
    private var mockDependencyContainer: MockDependencyContainer!
    private var newsCoordinator: NewsCoordinator!

    override func setUp() {
        super.setUp()

        navigationController = UINavigationController()
        mockDependencyContainer = MockDependencyContainer()
        newsCoordinator = NewsCoordinator(navigationController: navigationController, dependencyContainer: mockDependencyContainer)
    }

    override func tearDown() {
        navigationController = nil
        mockDependencyContainer = nil
        newsCoordinator = nil

        super.tearDown()
    }

    func testStartSetsNewsListViewController() {
        newsCoordinator.start()

        XCTAssertNotNil(navigationController.viewControllers.first as? NewsListViewController)
    }

    func testDidSelectArticleStartsArticleDetailCoordinator() {
        newsCoordinator.start()

        let newsListViewModel = mockDependencyContainer.resolve(NewsListViewModelType.self) as! MockNewsListViewModel
        newsListViewModel.coordinatorDelegate = newsCoordinator
        newsListViewModel.coordinatorDelegate?.didSelectArticle(Article.dummy)

        XCTAssertTrue(newsCoordinator.childCoordinators.contains(where: { $0 is ArticleDetailCoordinator }))
    }

    func testDidCloseArticleRemovesArticleDetailCoordinator() {
        newsCoordinator.start()

        let newsListViewModel = mockDependencyContainer.resolve(NewsListViewModelType.self) as! MockNewsListViewModel
        newsListViewModel.coordinatorDelegate = newsCoordinator
        newsListViewModel.coordinatorDelegate?.didSelectArticle(Article.dummy)

        let articleDetailCoordinator = newsCoordinator.childCoordinators.first(where: { $0 is ArticleDetailCoordinator }) as! ArticleDetailCoordinator
        articleDetailCoordinator.delegate?.didCloseArticle()

        XCTAssertFalse(newsCoordinator.childCoordinators.contains(where: { $0 is ArticleDetailCoordinator }))
    }
}
