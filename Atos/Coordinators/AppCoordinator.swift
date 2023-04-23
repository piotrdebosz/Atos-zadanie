import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DependencyContainerType

    init(navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        // We always start with login coordinator because logged in user
        // is not persisted. This is because there is no requirement
        // to persist the user and there is no log out button.
        // In the future we should check if there is already logged in user
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

        releaseLoginCoordinator()
    }

    func releaseLoginCoordinator() {
        let loginCoordinator = childCoordinators.first { $0 is LoginCoordinator }
        loginCoordinator?.stop()

        childCoordinators = childCoordinators.filter { !($0 is LoginCoordinator) }
    }
}
