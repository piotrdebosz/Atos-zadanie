import Foundation
@testable import Atos

class MockArticleDetailViewModel: ArticleDetailViewModelType {
    weak var delegate: ArticleDetailViewModelDelegate?

    var author: String = ""
    var title: String = ""
    var description: String = ""
    var publishedAt: String = ""
    var imageData: Data?
    var isImageLoading: Bool = false

    var viewDidLoadCalled = false

    func viewDidLoad() {
        viewDidLoadCalled = true
    }
}
