import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DependencyContainerType

    init(navigationController: UINavigationController, dependencyContainer: DependencyContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func prepareAndPresentTabBarController(viewControllers: [UIViewController]) {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.applyAtosStyling()
        tabBarController.viewControllers = viewControllers

        navigationController.pushViewController(tabBarController, animated: true)
    }

    func start() {
        let feedNavigationController = UINavigationController()
        let feedCoordinator = FeedCoordinator(
            navigationController: feedNavigationController,
            dependencyContainer: dependencyContainer
        )

        feedCoordinator.start()

        let accountNavigationController = UINavigationController()
        let accountCoordinator = AccountCoordinator(
            navigationController: accountNavigationController,
            dependencyContainer: dependencyContainer
        )

        accountCoordinator.start()

        childCoordinators = [feedCoordinator, accountCoordinator]

        prepareAndPresentTabBarController(viewControllers: [
            feedNavigationController,
            accountNavigationController
        ])
    }
}
