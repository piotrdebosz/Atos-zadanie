import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DependencyContainerType

    init(navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let loginCoordinator = LoginCoordinator(
            navigationController: navigationController,
            dependencyContainer: dependencyContainer
        )

        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }

    // Starts the home flow after successful login
    func didFinishLogin() {
        let homeCoordinator = HomeCoordinator(
            navigationController: navigationController,
            dependencyContainer: dependencyContainer
        )
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
