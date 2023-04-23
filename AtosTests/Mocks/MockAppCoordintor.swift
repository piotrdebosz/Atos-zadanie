import Foundation
@testable import Atos

class MockAppCoordinator: AppCoordinator {
    var didFinishLoginCalled = false

    override func didFinishLogin() {
        didFinishLoginCalled = true
    }
}
