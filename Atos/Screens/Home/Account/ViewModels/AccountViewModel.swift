import Foundation

class AccountViewModel: AccountViewModelType {
    private let authenticationService: AuthenticationServiceType

    // Keep dateFormatter instance because it's very
    // expensive in terms of performance to create new one
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"

        return dateFormatter
    }()

    init(authenticationService: AuthenticationServiceType) {
        self.authenticationService = authenticationService
    }

    var userName: String {
        currentUser.userName
    }

    var avatarName: String {
        currentUser.avatarFileName
    }

    var lastLogin: String {
        dateFormatter.string(from: currentUser.lastLoginTime)
    }

    private var currentUser: User {
        guard let currentUser = authenticationService.currentUser else {
            fatalError("You cannot be here without logged in user")
        }

        return currentUser
    }
}
