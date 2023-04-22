import Foundation

// TODO: change names to ArticleDetail... and move to other directory
protocol ArticleViewModelDelegate: AnyObject {
    func didChangeImageLoadingState(isLoading: Bool)
    func didLoadImage(imageData: Data)
}
