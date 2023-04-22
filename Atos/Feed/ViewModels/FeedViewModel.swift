import Foundation

protocol FeedViewModelDelegate: AnyObject {
    func loadedArticles(articles: [ArticleListCellViewModelType])
    func failedToLoadArticles(error: Error)
    func didChangeLoadingState(isLoading: Bool)
}

protocol FeedViewModelType: AnyObject {
    var delegate: FeedViewModelDelegate? { get set }
    var coordinatorDelegate: FeedCoordinatorDelegate? { get set }

    var userName: String { get }

    func viewDidLoad()
    func scrolledToTheBottom()
    func refreshDataInitiatedByUser()
    func userSelectedArticle(at index: Int)
}

class FeedViewModel: FeedViewModelType {
    private let networkManager: NetworkManagerType

    weak var delegate: FeedViewModelDelegate?
    weak var coordinatorDelegate: FeedCoordinatorDelegate?

    var articles: [Article] = [] {
        didSet {
            articlesListCellViewModels = createArticlesListCellViewModels(articles: articles)
        }
    }

    var articlesListCellViewModels: [ArticleListCellViewModelType] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.loadedArticles(articles: self.articlesListCellViewModels)
            }
        }
    }

    var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didChangeLoadingState(isLoading: self.isLoading)
            }
        }
    }

    var userName: String {
        guard let user = authenticationService.currentUser else {
            fatalError("You cannot be here without logged in user")
        }

        return user.login
    }

    private var lastDownloadedPage = 1
    private var hasMorePages = true

    private let authenticationService: AuthenticationServiceType

    init(networkManager: NetworkManagerType, authenticationService: AuthenticationServiceType) {
        self.networkManager = networkManager
        self.authenticationService = authenticationService
    }

    func viewDidLoad() {
        fetchArticles()
    }

    func scrolledToTheBottom() {
        if hasMorePages {
            fetchArticles(page: lastDownloadedPage + 1)
        }
    }

    func refreshDataInitiatedByUser() {
        fetchArticles()
    }

    private func createArticlesListCellViewModels(articles: [Article]) -> [ArticleListCellViewModelType] {
        return articles.map { article in
            ArticleListCellViewModel(author: article.author, title: article.title)
        }
    }

    func userSelectedArticle(at index: Int) {
        coordinatorDelegate?.didSelectArticle(articles[index])
    }

    func fetchArticles(page: Int? = nil) {
        guard !isLoading else {
            return
        }

        isLoading = true

        Task {
            let result: Result<ArticleResponse, Error> = await networkManager
                .request(endpoint: NewsAPI.getTopHeadlines(country: "us", page: page))

            switch result {
            case let .success(response):
                if let page = page {
                    lastDownloadedPage = page

                    let newArticles = articles + response.articles
                    articles = newArticles
                } else {
                    lastDownloadedPage = 1
                    articles = response.articles
                }

                let totalResults = response.totalResults
                hasMorePages = articlesListCellViewModels.count < totalResults

            case let .failure(error):
                DispatchQueue.main.async {
                    self.delegate?.failedToLoadArticles(error: error)
                }
            }

            isLoading = false
        }
    }
}
