import UIKit

class LoginCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DIContainerType

    init(navigationController: UINavigationController, dependencyContainer: DIContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let loginViewController = LoginViewController(viewModel: dependencyContainer.resolve(LoginViewModelType.self))
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: false)
    }

    func didFinishLogin() {
        parentCoordinator?.didFinishLogin()
    }
}
