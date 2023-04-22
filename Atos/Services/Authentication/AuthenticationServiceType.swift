import Foundation

enum AuthenticationError: Swift.Error {
    case missingUser
    case wrongPassword
}

protocol AuthenticationServiceType {
    var currentUser: User? { get }

    func login(login: String, password: String) async -> Result<User, AuthenticationError>
}
