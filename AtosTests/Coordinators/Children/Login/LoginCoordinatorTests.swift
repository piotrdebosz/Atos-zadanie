@testable import Atos
import XCTest

class LoginCoordinatorTests: XCTestCase {
    private var navigationController: UINavigationController!
    private var mockDependencyContainer: MockDependencyContainer!
    private var loginCoordinator: LoginCoordinator!

    override func setUp() {
        super.setUp()

        navigationController = UINavigationController()
        mockDependencyContainer = MockDependencyContainer()
        loginCoordinator = LoginCoordinator(navigationController: navigationController, dependencyContainer: mockDependencyContainer)
    }

    override func tearDown() {
        navigationController = nil
        mockDependencyContainer = nil
        loginCoordinator = nil

        super.tearDown()
    }

    func testStartSetsLoginViewController() {
        loginCoordinator.start()

        XCTAssertTrue(navigationController.topViewController is LoginViewController)
    }

    func testStopRemovesLoginViewController() {
        loginCoordinator.start()
        loginCoordinator.stop()

        XCTAssertFalse(navigationController.viewControllers.contains(where: { $0 is LoginViewController }))
    }

    func testDidFinishLoginCallsParentCoordinator() {
        let mockAppCoordinator = MockAppCoordinator(navigationController: navigationController, dependencyContainer: mockDependencyContainer)
        loginCoordinator.parentCoordinator = mockAppCoordinator

        loginCoordinator.didFinishLogin()

        XCTAssertTrue(mockAppCoordinator.didFinishLoginCalled)
    }
}
