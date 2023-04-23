import Foundation

protocol ArticleDetailViewModelType: AnyObject {
    var author: String { get }
    var title: String { get }
    var description: String { get }
    var publishedAt: String { get }

    var delegate: ArticleDetailViewModelDelegate? { get set }

    var isImageLoading: Bool { get }
    var imageData: Data? { get }

    func viewDidLoad()
}
