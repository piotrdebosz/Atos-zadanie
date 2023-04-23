import Foundation

final class LoginViewModel: LoginViewModelType {
    private let authenticationService: AuthenticationServiceType
    weak var delegate: LoginViewModelDelegate?

    init(authenticationService: AuthenticationServiceType) {
        self.authenticationService = authenticationService
    }

    func userPressedLoginButton(login: String, password: String) {
        // Don't try to login when login or password is empty
        guard EmptyValidator.isValid(login), EmptyValidator.isValid(password) else {
            handleLoginError()

            return
        }

        Task(priority: .userInitiated) {
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
}
