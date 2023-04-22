import UIKit

class LoginViewController: UIViewController, Alertable {
    private let loginView = LoginView()
    private let viewModel: LoginViewModelType
    weak var coordinator: LoginCoordinator?

    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc private func loginButtonTapped() {
        let login = loginView.loginTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""

        viewModel.userPressedLoginButton(login: login, password: password)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginDidFail() {
        showAlertWithMessage(title: "Error", message: "Logowanie sie nie powiodło.")
    }
    
    func loginSuccessful() {
        coordinator?.didFinishLogin()
    }
}
