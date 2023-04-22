import Foundation

class AccountViewModel: AccountViewModelType {
    private let authenticationService: AuthenticationServiceType

    // TODO: change
    private let loggedInTime: Date = .init()

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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: loggedInTime)
    }

    private var currentUser: User {
        guard let currentUser = authenticationService.currentUser else {
            fatalError("You cannot be here without logged in user")
        }

        return currentUser
    }
}
