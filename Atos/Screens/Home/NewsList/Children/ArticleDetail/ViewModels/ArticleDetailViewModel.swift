import Foundation

class ArticleDetailViewModel: ArticleDetailViewModelType {
    private let article: Article
    private let imageLoader: ImageLoaderType

    private(set) var isImageLoading = false {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didChangeImageLoadingState()
            }
        }
    }

    weak var delegate: ArticleDetailViewModelDelegate?

    var author: String {
        if let author = article.author, !author.isEmpty {
            return author
        }

        return "Anonim"
    }

    var title: String {
        return article.title
    }

    var description: String {
        return article.description ?? ""
    }

    var publishedAt: String {
        return article.publishedAt
    }

    private(set) var imageData: Data?

    private var imageURL: URL? {
        guard let urlToImage = article.urlToImage else { return nil }
        return URL(string: urlToImage)
    }

    init(article: Article, imageLoader: ImageLoaderType) {
        self.article = article
        self.imageLoader = imageLoader
    }

    func viewDidLoad() {
        loadImage()
    }

    private func loadImage() {
        guard let imageURL = imageURL else { return }

        isImageLoading = true

        Task {
            guard let imageData = await imageLoader.loadImage(from: imageURL) else {
                return
            }

            self.imageData = imageData

            await MainActor.run {
                delegate?.didLoadImage()
            }

            isImageLoading = false
        }
    }
}
