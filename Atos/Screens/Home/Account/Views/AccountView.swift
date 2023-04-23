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

        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "User Avatar"

        return imageView
    }()

    let usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.font = .atosFont(ofSize: 13, weight: .semibold)

        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .atosFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0

        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true

        return label
    }()

    let lastLoginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Last login:"
        label.font = .atosFont(ofSize: 13, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    let lastLoginLabel: UILabel = {
        let label = UILabel()
        label.font = .atosFont(ofSize: 13, weight: .regular)

        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .white

        addSubview(stackView)

        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(usernameTitleLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(lastLoginTitleLabel)
        stackView.addArrangedSubview(lastLoginLabel)

        stackView.setCustomSpacing(48, after: avatarImageView)
        stackView.setCustomSpacing(24, after: usernameLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
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
