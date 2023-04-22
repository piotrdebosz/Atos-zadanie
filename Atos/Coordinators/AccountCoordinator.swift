import UIKit

class AccountCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    let dependencyContainer: DIContainerType

    init(navigationController: UINavigationController, dependencyContainer: DIContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let viewController = AccountViewController(viewModel: dependencyContainer.resolve(AccountViewModelType.self))
        navigationController.setViewControllers([viewController], animated: false)
    }
}
