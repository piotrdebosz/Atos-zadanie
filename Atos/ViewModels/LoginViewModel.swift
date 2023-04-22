import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func loginDidFail()
    func loginSuccessful()
}

protocol LoginViewModelType: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }

    func userPressedLoginButton(login: String, password: String)
}

class LoginViewModel: LoginViewModelType {
    private let authenticationService: AuthenticationServiceType
    weak var delegate: LoginViewModelDelegate?

    init(authenticationService: AuthenticationServiceType) {
        self.authenticationService = authenticationService
    }

    func userPressedLoginButton(login: String, password: String) {
        guard validateEmpty(login: login, password: password) else {
            handleLoginError()

            return
        }

        Task {
            let result = await authenticationService.login(login: login, password: password)

            switch result {
            case .success:
                await MainActor.run {
                    delegate?.loginSuccessful()
                }

            case .failure:
                await MainActor.run {
                    handleLoginError()
                }
            }
        }
    }

    private func handleLoginError() {
        delegate?.loginDidFail()
    }

    private func validateEmpty(login: String?, password: String?) -> Bool {
        guard let login = login, let password = password else {
            return false
        }

        return !login.isEmpty && !password.isEmpty
    }
}
