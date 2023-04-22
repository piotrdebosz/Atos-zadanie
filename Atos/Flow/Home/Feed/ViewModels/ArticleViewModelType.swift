import Foundation

protocol ArticleViewModelType: AnyObject {
    // TODO: unify names
    var authorText: String { get }
    var titleText: String { get }
    var descriptionText: String { get }
    var publishedAtText: String { get }

    var delegate: ArticleViewModelDelegate? { get set }

    func viewDidLoad()
}
