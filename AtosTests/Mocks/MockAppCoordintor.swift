@testable import Atos
import Foundation

class MockAppCoordinator: AppCoordinator {
    var didFinishLoginCalled = false

    override func didFinishLogin() {
        didFinishLoginCalled = true
    }
}
