import UIKit

class FeedViewController: UIViewController, CastView, Alertable {
    typealias CastView = FeedView

    private let viewModel: FeedViewModelType

    private let tableViewDataSource = FeedUITableViewDataSource()

    private lazy var tableViewDelegate = {
        let delegate = FeedUITableViewDelegate()
        delegate.delegate = self

        return delegate
    }()

    init(viewModel: FeedViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.viewModel.delegate = self
    }

    override func loadView() {
        view = FeedView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "News's for \(viewModel.userName)"
        navigationItem.backButtonTitle = "Back"

        navigationController?.navigationBar.applyAtosStyling()

        // TODO: move
        castView.tableView.dataSource = tableViewDataSource
        castView.tableView.delegate = tableViewDelegate
        castView.tableView.registerCell(ArticleCell.self)

        castView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        viewModel.viewDidLoad()
    }

    @objc private func refreshData() {
        viewModel.refreshDataInitiatedByUser()
    }

    private func configureTabBarItem() {
        // TODO: change image
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .small)

        let accountTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house", withConfiguration: imageConfiguration),
            tag: 1
        )

        tabBarItem = accountTabBarItem
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// TODO: Move
extension FeedViewController: FeedUITableViewDelegateDelegate {
    func userDidScrollToBottom() {
        viewModel.scrolledToTheBottom()
    }

    func userPressedCell(at indexPath: IndexPath) {
        viewModel.userSelectedArticle(at: indexPath.row)
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func loadedArticles(articles: [ArticleListCellViewModelType]) {
        tableViewDataSource.update(viewModels: articles)
        castView.tableView.reloadData()
        castView.refreshControl.endRefreshing()
    }

    func failedToLoadArticles(error: Error) {
        // TODO: change alert
        showAlertWithError(error)
    }

    func didChangeLoadingState(isLoading: Bool) {
        if isLoading {
            castView.footerActivityIndicator.startAnimating()
            castView.tableView.tableFooterView = castView.footerView
        } else {
            castView.footerActivityIndicator.stopAnimating()
            castView.tableView.tableFooterView = nil
        }
    }
}
