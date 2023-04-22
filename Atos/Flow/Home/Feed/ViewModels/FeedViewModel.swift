import Foundation

final class FeedViewModel: FeedViewModelType {
    private let networkingService: NetworkingServiceType
    private let authenticationService: AuthenticationServiceType

    weak var delegate: FeedViewModelDelegate?
    weak var coordinatorDelegate: FeedCoordinatorDelegate?

    private var articles: [Article] = [] {
        didSet {
            articlesListCellViewModels = articles.map { article in
                ArticleListCellViewModel(author: article.author, title: article.title)
            }
        }
    }

    private var articlesListCellViewModels: [ArticleListCellViewModelType] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.loadedArticles(articles: self.articlesListCellViewModels)
            }
        }
    }

    private var isLoading = false {
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

        return user.userName
    }

    // According to the API documentation in order to get all
    // articles we need to handle pagination.
    private var paginationData = PaginationData()

    init(networkingService: NetworkingServiceType, authenticationService: AuthenticationServiceType) {
        self.networkingService = networkingService
        self.authenticationService = authenticationService
    }

    func viewDidLoad() {
        fetchArticles()
    }

    func scrolledToTheBottom() {
        if paginationData.hasMorePages {
            fetchArticles(page: paginationData.currentPageNumber + 1)
        }
    }

    func refreshDataInitiatedByUser() {
        fetchArticles()
    }

    func userSelectedArticle(at index: Int) {
        coordinatorDelegate?.didSelectArticle(articles[index])
    }

    // If the page is nil it means we need to remove all data
    // and download first page again, it's happening
    // when user does pull down to refresh
    private func fetchArticles(page: Int? = nil) {
        guard !isLoading else {
            return
        }

        isLoading = true

        Task {
            let result: Result<ArticleResponse, Error> = await networkingService
                .request(endpoint: NewsAPI.getTopHeadlines(country: "us", page: page))

            switch result {
            case let .success(response):
                // Add articles from given page to the currently hold articles
                if let page = page {
                    paginationData.currentPageNumber = page

                    let newArticles = articles + response.articles
                    articles = newArticles
                } else {
                    // Remove all articles and keep only downloaded ones
                    paginationData.currentPageNumber = paginationData.initialPageNumber
                    articles = response.articles
                }

                // If we get same amount of articles as in totalResults then it means
                // that there is no more pages
                let totalResults = response.totalResults
                paginationData.hasMorePages = articlesListCellViewModels.count < totalResults

            case let .failure(error):
                DispatchQueue.main.async {
                    self.delegate?.failedToLoadArticles(error: error)
                }
            }

            isLoading = false
        }
    }
}
