import UIKit

final class LoginCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DependencyContainerType

    init(navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let loginViewModel = dependencyContainer.resolve(LoginViewModelType.self)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        loginViewController.coordinator = self

        navigationController.pushViewController(loginViewController, animated: false)
    }

    func stop() {
        let viewControllers = navigationController.viewControllers
        navigationController.viewControllers = viewControllers.filter { !($0 is LoginViewController) }
    }

    func didFinishLogin() {
        parentCoordinator?.didFinishLogin()
    }
}
