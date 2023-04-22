import UIKit

class LoginViewController: UIViewController, CastView, Alertable {
    typealias CastView = LoginView

    private let viewModel: LoginViewModelType
    weak var coordinator: LoginCoordinator?

    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.viewModel.delegate = self
    }

    override func loadView() {
        view = LoginView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        castView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc private func loginButtonTapped() {
        let login = castView.loginTextField.text ?? ""
        let password = castView.passwordTextField.text ?? ""

        viewModel.userPressedLoginButton(login: login, password: password)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Handle ViewModel events
extension LoginViewController: LoginViewModelDelegate {
    func loginDidFail() {
        showAlertWithMessage(title: "Error", message: "Logowanie sie nie powiodło.")
    }

    func loginSuccessful() {
        coordinator?.didFinishLogin()
    }
}
