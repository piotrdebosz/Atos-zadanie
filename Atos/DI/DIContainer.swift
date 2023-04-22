//
//  DIContainer.swift
//  Atos
//
//  Created by Piotr Debosz on 22/04/2023.
//

import Foundation

class DIContainer: DIContainerType {
    var factories: [AnyHashable : (factory: Factory, scope: DependencyScope)] = [:]
    var sharedDepenedencies: [AnyHashable : Any] = [:]
    
    init() {
        registerServices()
        registerViewModels()
    }
    
    private func registerServices() {
        register(AuthenticationServiceType.self, scope: .shared) { _ in
            AuthenticationMockService()
        }
        
        register(NetworkManagerType.self, scope: .shared) { _ in
            NetworkManager()
        }
    }
    
    private func registerViewModels() {
        register(LoginViewModelType.self, scope: .transient) { resolver in
            LoginViewModel(authenticationService: resolver.resolve(AuthenticationServiceType.self))
        }
        
        register(FeedViewModelType.self, scope: .transient) { resolver in
            FeedViewModel(networkManager: resolver.resolve(NetworkManagerType.self),
                          authenticationService: resolver.resolve(AuthenticationServiceType.self))
        }
        
        register(AccountViewModelType.self, scope: .transient) { resolver in
            AccountViewModel(authenticationService: resolver.resolve(AuthenticationServiceType.self))
        }
    }
}
