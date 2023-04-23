import XCTest
@testable import Atos

class AppCoordinatorTests: XCTestCase {
    var navigationController: MockNavigationController!
    var dependencyContainer: DependencyContainerType!
    var appCoordinator: AppCoordinator!

    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        dependencyContainer = MockDependencyContainer()
        appCoordinator = AppCoordinator(navigationController: navigationController, dependencyContainer: dependencyContainer)
    }

    func testStart_startsLoginCoordinator() {
        appCoordinator.start()

        XCTAssertTrue(appCoordinator.childCoordinators.first is LoginCoordinator, "AppCoordinator should start the LoginCoordinator.")
    }

    func testDidFinishLogin_startsHomeCoordinatorAndReleasesLoginCoordinator() {
        appCoordinator.start()

        appCoordinator.didFinishLogin()

        XCTAssertTrue(appCoordinator.childCoordinators.first is HomeCoordinator, "AppCoordinator should start the HomeCoordinator.")
        XCTAssertFalse(appCoordinator.childCoordinators.contains { $0 is LoginCoordinator }, "AppCoordinator should release the LoginCoordinator.")
    }
}
