import Foundation

protocol AccountViewModelType {
    var userName: String { get }
    var lastLogin: String { get }
    var avatarName: String { get }
}

class AccountViewModel: AccountViewModelType {
    private let authenticationService: AuthenticationServiceType
    private let loggedInTime: Date = Date()
    
    init(authenticationService: AuthenticationServiceType) {
        self.authenticationService = authenticationService
    }
    
    var userName: String {
        currentUser.login
    }
    
    var avatarName: String {
        currentUser.avatarName
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
