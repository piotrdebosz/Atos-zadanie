import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let dependencyContainer: DIContainerType

    init(navigationController: UINavigationController, dependencyContainer: DIContainerType) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func start() {
        let tabBarController = UITabBarController()

        let feedNavigationController = UINavigationController()
        let accountNavigationController = UINavigationController()

        tabBarController.viewControllers = [feedNavigationController, accountNavigationController]
        tabBarController.tabBar.applyAtosStyling()

        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .small)

        let feedTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house", withConfiguration: imageConfiguration),
            tag: 0)

        feedNavigationController.tabBarItem = feedTabBarItem

        let accountTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person", withConfiguration: imageConfiguration),
            tag: 1)
        accountNavigationController.tabBarItem = accountTabBarItem

        let feedCoordinator = FeedCoordinator(
            navigationController: feedNavigationController,
            dependencyContainer: dependencyContainer)
        feedCoordinator.start()

        let accountCoordinator = AccountCoordinator(
            navigationController: accountNavigationController,
            dependencyContainer: dependencyContainer)
        accountCoordinator.start()

        childCoordinators = [feedCoordinator, accountCoordinator]

        navigationController.pushViewController(tabBarController, animated: true)
    }
}
