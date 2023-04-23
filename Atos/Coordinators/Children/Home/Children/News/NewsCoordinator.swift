import UIKit

final class NewsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    private let dependencyContainer: DependencyContainerType

    init(navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let newsListViewModel = dependencyContainer.resolve(NewsListViewModelType.self)
        newsListViewModel.coordinatorDelegate = self

        let newsListViewController = NewsListViewController(viewModel: newsListViewModel)
        navigationController.setViewControllers([newsListViewController], animated: false)
    }

    private func startArticleDetailCoordinator(_ article: Article) {
        let articleDetailCoordinator = ArticleDetailCoordinator(
            article: article,
            navigationController: navigationController,
            dependencyContainer: dependencyContainer)

        articleDetailCoordinator.delegate = self

        articleDetailCoordinator.start()

        childCoordinators.append(articleDetailCoordinator)
    }
}

extension NewsCoordinator: NewsListViewModelCoordinatorDelegate {
    func didSelectArticle(_ article: Article) {
        startArticleDetailCoordinator(article)
    }
}

extension NewsCoordinator: ArticleDetailCoordinatorDelegate {
    func didCloseArticle() {
        let articleDetailCoordinator = childCoordinators.first { $0 is ArticleDetailCoordinator }
        articleDetailCoordinator?.stop()

        childCoordinators = childCoordinators.filter { !($0 is ArticleDetailCoordinator) }
    }
}
