import XCTest
@testable import Atos

class HomeCoordinatorTests: XCTestCase {
    private var navigationController: UINavigationController!
    private var mockDependencyContainer: MockDependencyContainer!
    private var homeCoordinator: HomeCoordinator!

    override func setUp() {
        super.setUp()

        navigationController = UINavigationController()
        mockDependencyContainer = MockDependencyContainer()
        homeCoordinator = HomeCoordinator(navigationController: navigationController, dependencyContainer: mockDependencyContainer)
    }

    override func tearDown() {
        navigationController = nil
        mockDependencyContainer = nil
        homeCoordinator = nil

        super.tearDown()
    }

    func testStartSetsTabBarController() {
        homeCoordinator.start()

        XCTAssertTrue(navigationController.topViewController is UITabBarController)
    }

    func testStartSetsNewsAndAccountCoordinatorsAsChildCoordinators() {
        homeCoordinator.start()

        XCTAssertTrue(homeCoordinator.childCoordinators.contains(where: { $0 is NewsCoordinator }))
        XCTAssertTrue(homeCoordinator.childCoordinators.contains(where: { $0 is AccountCoordinator }))
    }

    func testStartSetsNewsAndAccountNavigationControllersAsTabBarViewControllers() {
        homeCoordinator.start()

        let tabBarController = navigationController.topViewController as! UITabBarController
        XCTAssertTrue(tabBarController.viewControllers?.contains(where: { $0 is UINavigationController && $0.children.first is NewsListViewController }) ?? false)
        XCTAssertTrue(tabBarController.viewControllers?.contains(where: { $0 is UINavigationController && $0.children.first is AccountViewController }) ?? false)
    }
}
