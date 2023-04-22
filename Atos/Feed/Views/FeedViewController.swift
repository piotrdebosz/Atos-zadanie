import UIKit

class FeedViewController: UIViewController {
    private let feedView = FeedView()
    private let viewModel: FeedViewModelType
    
    private let dataSource = FeedUITableViewDataSource()
    
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

    // TODO: move
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // TODO change
        view = feedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News's for \(viewModel.userName)"
        navigationItem.backButtonTitle = "Back"
        
        navigationController?.navigationBar.applyAtosStyling()
        
        feedView.tableView.dataSource = dataSource
        feedView.tableView.delegate = tableViewDelegate
        feedView.tableView.registerCell(ArticleCell.self)
//        feedView.tableView.delegate = self
        
        feedView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        viewModel.viewDidLoad()
    }
    
    @objc func refreshData() {
        viewModel.refreshDataInitiatedByUser()
    }
}

extension FeedViewController: Alertable {}

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
        print("FeedViewController, loaded articles: \(articles.count)")
        dataSource.update(viewModels: articles)
        feedView.tableView.reloadData()
        feedView.refreshControl.endRefreshing()
    }
    
    func failedToLoadArticles(error: Error) {
        print("FeedViewController, failed to load articles")
        showAlertWithError(error)
    }
    
    func didChangeLoadingState(isLoading: Bool) {
        if isLoading {
            feedView.footerActivityIndicator.startAnimating()
            feedView.tableView.tableFooterView = feedView.footerView
        } else {
            feedView.footerActivityIndicator.stopAnimating()
            feedView.tableView.tableFooterView = nil
        }
    }
}
