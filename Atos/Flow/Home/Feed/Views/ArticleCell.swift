import UIKit

class ArticleCell: UITableViewCell {
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    func configure(author: String, title: String) {
        authorLabel.text = author
        titleLabel.text = title
    }

    private func setupViews() {
        addSubview(authorLabel)
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            titleLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
