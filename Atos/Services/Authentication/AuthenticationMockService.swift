import Foundation

// A mock authentication service used for testing purposes.
// Replace with a real authentication service in production.
//
class AuthenticationMockService: AuthenticationServiceType {
    typealias LoginData = (login: String, password: String)

    private let authenticationData: [LoginData] = [
        (login: "Admin", password: "Admin1234"),
        (login: "Kasia", password: "Kasia1234")
    ]

    private let usersData: [User] = [
        User(userName: "Admin", avatarFileName: "Admin.png", lastLoginTime: Date()),
        User(userName: "Kasia", avatarFileName: "Kasia.png", lastLoginTime: Date())
    ]

    private(set) var currentUser: User?

    // Performs login and returns a User object if successful,
    // otherwise an AuthenticationError.
    func login(login: String, password: String) async -> Result<User, AuthenticationError> {
        guard let userAuthenticationData = authenticationData.first(where: { $0.login == login }) else {
            return .failure(.missingUser)
        }

        guard userAuthenticationData.password == password else {
            return .failure(.wrongPassword)
        }

        let user = findUser(with: login)
        currentUser = user

        return .success(user)
    }

    // Finds a User object matching the given login.
    private func findUser(with login: String) -> User {
        guard let user = usersData.first(where: { $0.userName == login }) else {
            fatalError("User is missing!")
        }

        return user
    }
}
