import UIKit

class ArticleDetailView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .atosFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0

        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true

        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .atosFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0

        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true

        return label
    }()

    let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.font = .atosFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center

        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .atosFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0

        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true

        return label
    }()

    let publishedAtTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Published at:"
        label.font = .atosFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0

        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = .atosFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0

        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true

        return label
    }()

    let imageView: LoadingImageView = {
        let imageView = LoadingImageView()
        imageView.contentMode = .scaleAspectFit

        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Article Image"

        return imageView
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white

        addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionTitleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(publishedAtTitleLabel)
        stackView.addArrangedSubview(publishedAtLabel)
        stackView.addArrangedSubview(imageView)

        stackView.setCustomSpacing(48, after: titleLabel)
        stackView.setCustomSpacing(24, after: descriptionTitleLabel)
        stackView.setCustomSpacing(20, after: descriptionLabel)
        stackView.setCustomSpacing(48, after: publishedAtLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48),

            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
