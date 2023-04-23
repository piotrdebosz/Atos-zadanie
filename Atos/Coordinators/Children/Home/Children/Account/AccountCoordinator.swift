import UIKit

final class AccountCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DependencyContainerType

    init(navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let accountViewModel = dependencyContainer.resolve(AccountViewModelType.self)
        let accountViewController = AccountViewController(viewModel: accountViewModel)

        navigationController.setViewControllers([accountViewController], animated: false)
    }
}
