import Foundation
@testable import Atos

class MockAuthenticationService: AuthenticationServiceType {
    var currentUser: User? = User(userName: "Test", avatarFileName: "Test", lastLoginTime: Date())

    private let validLogin = "validLogin"
    private let validPassword = "validPassword"

    func login(login: String, password: String) async -> Result<User, AuthenticationError> {
        if login == validLogin && password == validPassword {
            let user = User(userName: "Test", avatarFileName: "Test", lastLoginTime: Date())

            self.currentUser = user
            return .success(user)
        } else if login != validLogin {
            return .failure(.missingUser)
        } else {
            return .failure(.wrongPassword)
        }
    }
}
