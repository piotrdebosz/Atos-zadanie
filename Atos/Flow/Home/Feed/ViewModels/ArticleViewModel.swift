import Foundation

class ArticleViewModel: ArticleViewModelType {
    private let article: Article
    private let imageLoader: ImageLoaderType

    private var isImageLoading = false {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didChangeImageLoadingState(isLoading: self.isImageLoading)
            }
        }
    }

    weak var delegate: ArticleViewModelDelegate?

    var articleTitle: String {
        return article.title
    }

    var authorText: String {
        // TODO: DRY, add decorator
        if let author = article.author, !author.isEmpty {
            return author
        }

        return "Anonim"
    }

    var titleText: String {
        return article.title
    }

    var descriptionText: String {
        return article.description ?? ""
    }

    var publishedAtText: String {
        return article.publishedAt
    }

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

            await MainActor.run {
                delegate?.didLoadImage(imageData: imageData)
            }

            isImageLoading = false
        }
    }
}
