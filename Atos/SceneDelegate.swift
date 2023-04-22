import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)

        let container = DependencyContainer()

        appCoordinator = AppCoordinator(navigationController: navigationController, dependencyContainer: container)
        appCoordinator?.start()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
