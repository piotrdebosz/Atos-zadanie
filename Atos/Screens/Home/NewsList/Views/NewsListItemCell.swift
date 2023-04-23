import UIKit

class NewsListItemCell: UITableViewCell {
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.atosFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true

        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.atosFont(ofSize: 13)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    func configure(newsItem: NewsListCellDataItem) {
        authorLabel.text = newsItem.author
        titleLabel.text = newsItem.title

        authorLabel.accessibilityLabel = "Author: \(newsItem.author)"
        titleLabel.accessibilityLabel = "Title: \(newsItem.title)"
    }

    private func setupViews() {
        addSubview(authorLabel)
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 96),
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            titleLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
