import UIKit

class LoginView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

    let headerView = UIView()

    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_header")
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let loginTextField: UITextField = {
        let textField = BorderedTextField()
        textField.placeholder = "Login"
        textField.returnKeyType = .next

        textField.isAccessibilityElement = true
        textField.accessibilityLabel = "Enter your login"
        textField.accessibilityHint = "Cannot be empty"
        textField.adjustsFontForContentSizeCategory = true

        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = BorderedTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done

        textField.isAccessibilityElement = true
        textField.accessibilityLabel = "Enter your password"
        textField.accessibilityHint = "Cannot be empty"
        textField.adjustsFontForContentSizeCategory = true

        return textField
    }()

    let loginButton: UIButton = {
        let button = PrimaryButton()
        button.setTitle("LOG IN", for: .normal)

        button.isAccessibilityElement = true
        button.accessibilityLabel = "Log in"
        button.titleLabel?.adjustsFontForContentSizeCategory = true

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .white

        headerView.addSubview(headerImageView)

        addSubview(stackView)

        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)

        stackView.setCustomSpacing(32, after: headerView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
