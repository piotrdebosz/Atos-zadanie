import Foundation

// Concrete implementation of the DependencyContainer.
// It should be instantiated only once in SceneDelegate
// and then injected to the Coordinators
// For testing purposes you can create mock implementation
// and use it in tests
//
class DependencyContainer: DependencyContainerType {
    var factories: [AnyHashable: DependencyEntryType] = [:]
    var sharedDepenedencies: [AnyHashable: Any] = [:]

    init() {
        registerServices()
        registerViewModels()
    }

    private func registerServices() {
        register(URLSession.self, scope: .shared) { _ in
            URLSession.shared
        }

        register(AuthenticationServiceType.self, scope: .shared) { _ in
            AuthenticationMockService()
        }

        register(NetworkingServiceType.self, scope: .shared) { resolver in
            NetworkingService(urlSession: resolver.resolve(URLSession.self))
        }

        register(ImageLoaderType.self, scope: .shared) { resolver in
            ImageLoader(urlSession: resolver.resolve(URLSession.self))
        }
    }

    private func registerViewModels() {
        register(LoginViewModelType.self, scope: .transient) { resolver in
            LoginViewModel(authenticationService: resolver.resolve(AuthenticationServiceType.self))
        }

        register(FeedViewModelType.self, scope: .transient) { resolver in
            FeedViewModel(
                networkingService: resolver.resolve(NetworkingServiceType.self),
                authenticationService: resolver.resolve(AuthenticationServiceType.self)
            )
        }

        register(ArticleViewModelType.self, scope: .transient) { resolver, article in
            ArticleViewModel(
                article: article,
                imageLoader: resolver.resolve(ImageLoaderType.self)
            )
        }

        register(AccountViewModelType.self, scope: .transient) { resolver in
            AccountViewModel(authenticationService: resolver.resolve(AuthenticationServiceType.self))
        }
    }
}
