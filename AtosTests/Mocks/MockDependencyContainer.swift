@testable import Atos
import XCTest

class MockDependencyContainer: DependencyContainerType {
    var factories: [AnyHashable: Atos.DependencyEntryType] = [:]
    var sharedDepenedencies: [AnyHashable: Any] = [:]

    init() {
        register(AuthenticationServiceType.self, scope: .shared) { _ in
            MockAuthenticationService()
        }

        register(ArticleDetailViewModelType.self, scope: .transient) { (_, _: Article) in
            MockArticleDetailViewModel()
        }

        register(LoginViewModelType.self, scope: .transient) { _ in
            MockLoginViewModel()
        }

        register(NewsListViewModelType.self, scope: .transient) { _ in
            MockNewsListViewModel()
        }

        register(AccountViewModelType.self, scope: .transient) { _ in
            MockAccountViewModel()
        }
    }
}
