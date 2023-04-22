import UIKit

protocol FeedCoordinatorDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let feedViewModel: FeedViewModelType
    
    private let dependencyContainer: DIContainerType

    init(navigationController: UINavigationController, dependencyContainer: DIContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
        
        
        let feedViewModel = dependencyContainer.resolve(FeedViewModelType.self)
        self.feedViewModel = feedViewModel
    }

    func start() {
        feedViewModel.coordinatorDelegate = self
        let feedViewController = FeedViewController(viewModel: feedViewModel)
        navigationController.setViewControllers([feedViewController], animated: false)
    }
}

extension FeedCoordinator: FeedCoordinatorDelegate {
    func didSelectArticle(_ article: Article) {
        let imageLoader = ImageLoader()
        let articleViewModel = ArticleViewModel(article: article, imageLoader: imageLoader)
        let articleViewController = ArticleViewController(viewModel: articleViewModel)
        navigationController.pushViewController(articleViewController, animated: true)
    }
}
