import UIKit

class NewsListView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsListItemCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    let footerView = UIView()
    let footerActivityIndicator = UIActivityIndicatorView(style: .medium)

    let refreshControl = UIRefreshControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundColor = .white

        addSubview(tableView)

        tableView.refreshControl = refreshControl

        footerView.addSubview(footerActivityIndicator)
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        footerActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            footerActivityIndicator.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            footerActivityIndicator.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
