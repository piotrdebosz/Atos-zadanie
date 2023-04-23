import Foundation

final class NewsListViewModel: NewsListViewModelType {
    private let networkingService: NetworkingServiceType
    private let authenticationService: AuthenticationServiceType

    weak var delegate: NewsListViewModelDelegate?
    weak var coordinatorDelegate: NewsListViewModelCoordinatorDelegate?

    private var articles: [Article] = []

    var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didChangeLoadingState()
            }
        }
    }

    var userName: String {
        guard let user = authenticationService.currentUser else {
            fatalError("You cannot be here without logged in user")
        }

        return user.userName
    }

    var numberOfItems: Int {
        articles.count
    }

    // According to the API documentation in order to get all
    // articles we need to handle pagination.
    private var paginationData = PaginationData()

    init(networkingService: NetworkingServiceType, authenticationService: AuthenticationServiceType) {
        self.networkingService = networkingService
        self.authenticationService = authenticationService
    }

    func newsItem(at index: Int) -> NewsListCellDataItem {
        let article = articles[index]

        var author = "Anonim"

        if let articleAuthor = article.author, !articleAuthor.isEmpty {
            author = articleAuthor
        }

        return NewsListCellDataItem(author: author, title: article.title)
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

                    articles.append(contentsOf: response.articles)
                } else {
                    // Remove all articles and keep only downloaded ones
                    paginationData.currentPageNumber = paginationData.initialPageNumber
                    articles = response.articles
                }

                // If we get same amount of articles as in totalResults then it means
                // that there is no more pages
                let totalResults = response.totalResults
                paginationData.hasMorePages = articles.count < totalResults

                await MainActor.run {
                    self.delegate?.didLoadArticles()
                }

            case let .failure(error):
                await MainActor.run {
                    self.delegate?.didFailToLoadArticles(error: error)
                }
            }

            isLoading = false
        }
    }
}
