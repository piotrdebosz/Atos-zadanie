import UIKit

class AccountView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"

        return label
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    let lastLoginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Last login:"

        return label
    }()

    let lastLoginLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white

        addSubview(stackView)

        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(usernameTitleLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(lastLoginTitleLabel)
        stackView.addArrangedSubview(lastLoginLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
