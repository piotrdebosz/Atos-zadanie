import UIKit

protocol FeedCoordinatorDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

final class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    private let dependencyContainer: DependencyContainerType

    init(navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let feedViewModel = dependencyContainer.resolve(FeedViewModelType.self)
        feedViewModel.coordinatorDelegate = self

        let feedViewController = FeedViewController(viewModel: feedViewModel)
        navigationController.setViewControllers([feedViewController], animated: false)
    }

    private func showArticleDetailScreen(_ article: Article) {
        let articleViewModel = dependencyContainer.resolve(ArticleViewModelType.self, arg: article)

        let articleViewController = ArticleViewController(viewModel: articleViewModel)
        navigationController.pushViewController(articleViewController, animated: true)
    }
}

extension FeedCoordinator: FeedCoordinatorDelegate {
    func didSelectArticle(_ article: Article) {
        showArticleDetailScreen(article)
    }
}
