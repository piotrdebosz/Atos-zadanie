@testable import Atos
import XCTest

class AccountCoordinatorTests: XCTestCase {
    var navigationController: MockNavigationController!
    var dependencyContainer: DependencyContainerType!
    var accountCoordinator: AccountCoordinator!

    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        dependencyContainer = DependencyContainer()
        accountCoordinator = AccountCoordinator(navigationController: navigationController, dependencyContainer: dependencyContainer)
    }

    func testStart_setsAccountViewControllerAsRoot() {
        accountCoordinator.start()

        XCTAssertTrue(navigationController.viewControllers.first is AccountViewController, "AccountCoordinator should set AccountViewController as the root view controller.")
    }
}
