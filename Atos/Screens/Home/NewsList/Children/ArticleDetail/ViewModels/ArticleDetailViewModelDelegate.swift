import Foundation

protocol ArticleDetailViewModelDelegate: AnyObject {
    func didChangeImageLoadingState()
    func didLoadImage()
}
