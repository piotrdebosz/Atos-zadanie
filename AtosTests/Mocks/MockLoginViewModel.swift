@testable import Atos
import Foundation

class MockLoginViewModel: LoginViewModelType {
    weak var delegate: LoginViewModelDelegate?

    var userPressedLoginButtonCalled = false
    var login: String?
    var password: String?

    func userPressedLoginButton(login: String, password: String) {
        userPressedLoginButtonCalled = true
        self.login = login
        self.password = password
    }
}
