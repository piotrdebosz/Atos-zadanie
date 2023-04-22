import UIKit

class ArticleView: UIView {
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
        label.font = UIFont.atosFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.atosFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0

        return label
    }()

    let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.font = UIFont.atosFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.atosFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0

        return label
    }()

    let publishedAtTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Published at:"
        label.font = UIFont.atosFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0

        return label
    }()

    let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.atosFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0

        return label
    }()

    let imageView: LoadingImageView = {
        let imageView = LoadingImageView()
        imageView.contentMode = .scaleAspectFit

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
        stackView.setCustomSpacing(24, after: descriptionLabel)
        stackView.setCustomSpacing(24, after: publishedAtLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),

            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
