import UIKit

class LoginView: UIView {
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .white

        addSubview(loginLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),

            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),

            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),

            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
