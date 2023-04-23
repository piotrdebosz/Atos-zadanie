import UIKit

class NewsListViewController: UIViewController, CastView, Alertable {
    typealias CastView = NewsListView

    private let viewModel: NewsListViewModelType

    init(viewModel: NewsListViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.viewModel.delegate = self

        configureTabBarItem()
    }

    override func loadView() {
        view = NewsListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()

        viewModel.viewDidLoad()
    }

    @objc private func refreshData() {
        viewModel.refreshDataInitiatedByUser()
    }

    private func configureNavigationBar() {
        navigationItem.title = "News's for \(viewModel.userName)"
        navigationItem.backButtonTitle = "Back"

        navigationController?.navigationBar.applyAtosStyling()
    }

    private func configureTableView() {
        castView.tableView.dataSource = self
        castView.tableView.delegate = self
        castView.tableView.registerCell(NewsListItemCell.self)

        castView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    private func configureTabBarItem() {
        tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_home"), selectedImage: nil)
        tabBarItem.accessibilityLabel = "Home"
        tabBarItem.accessibilityIdentifier = "tabBarItem_home"
        tabBarItem.isAccessibilityElement = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsListViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(NewsListItemCell.self, for: indexPath)
        cell.configure(newsItem: viewModel.newsItem(at: indexPath.row))

        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.scrolledToTheBottom()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        viewModel.userSelectedArticle(at: indexPath.row)
    }
}

extension NewsListViewController: NewsListViewModelDelegate {
    func didLoadArticles() {
        castView.tableView.reloadData()
        castView.refreshControl.endRefreshing()
    }

    func didFailToLoadArticles(error: Error) {
        showAlertWithError(error)
    }

    func didChangeLoadingState() {
        if viewModel.isLoading {
            castView.footerActivityIndicator.startAnimating()
            castView.tableView.tableFooterView = castView.footerView
        } else {
            castView.footerActivityIndicator.stopAnimating()
            castView.tableView.tableFooterView = nil
        }
    }
}
