import Foundation

protocol ArticleViewModelDelegate: AnyObject {
    func didChangeImageLoadingState(isLoading: Bool)
    func didLoadImage(imageData: Data)
}

protocol ArticleViewModelType: AnyObject {
    var authorText: String { get }
    var titleText: String { get }
    var descriptionText: String { get }
    var publishedAtText: String { get }
    
    var delegate: ArticleViewModelDelegate? { get set }
    
    func viewDidLoad()
}

class ArticleViewModel: ArticleViewModelType {
    private let article: Article
    private let imageLoader: ImageLoader
    private var isImageLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didChangeImageLoadingState(isLoading: self.isImageLoading)
            }
        }
    }
    
    weak var delegate: ArticleViewModelDelegate?
    
    init(article: Article, imageLoader: ImageLoader) {
        self.article = article
        self.imageLoader = imageLoader
    }
    
    var articleTitle: String {
        return article.title
    }
    
    var authorText: String {
        if let author = article.author, author != "" {
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
