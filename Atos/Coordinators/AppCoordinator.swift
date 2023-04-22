import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DIContainerType
    
    init(navigationController: UINavigationController, dependencyContainer: DIContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, dependencyContainer: dependencyContainer)
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }

    func didFinishLogin() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, dependencyContainer: dependencyContainer)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
