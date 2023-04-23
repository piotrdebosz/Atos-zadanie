import XCTest
@testable import Atos

class ArticleDetailCoordinatorTests: XCTestCase {
    var navigationController: MockNavigationController!
    var dependencyContainer: DependencyContainerType!
    var articleDetailCoordinator: ArticleDetailCoordinator!
    let article = Article(author: "Author", title: "Title", description: "Description", urlToImage: nil, publishedAt: "2021-01-01")

    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        dependencyContainer = MockDependencyContainer()
        articleDetailCoordinator = ArticleDetailCoordinator(article: article, navigationController: navigationController, dependencyContainer: dependencyContainer)
    }

    func testStart_pushesArticleDetailViewController() {
        articleDetailCoordinator.start()

        XCTAssertTrue(navigationController.viewControllers.first is ArticleDetailViewController, "ArticleDetailCoordinator should push ArticleDetailViewController.")
    }
}
