import UIKit

final class ArticleDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    weak var delegate: ArticleDetailCoordinatorDelegate?

    private let dependencyContainer: DependencyContainerType

    private let article: Article

    init(article: Article, navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
        self.article = article
    }

    func start() {
        let articleDetailViewModel = dependencyContainer.resolve(ArticleDetailViewModelType.self, arg: article)

        let articleDetailViewController = ArticleDetailViewController(viewModel: articleDetailViewModel)
        articleDetailViewController.delegate = self
        navigationController.pushViewController(articleDetailViewController, animated: true)
    }
}

extension ArticleDetailCoordinator: ArticleDetailViewControllerDelegate {
    func viewDidDisappear() {
        self.delegate?.didCloseArticle()
    }
}
