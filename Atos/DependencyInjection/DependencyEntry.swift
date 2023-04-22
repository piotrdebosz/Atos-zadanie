import Foundation

// DependencyEntry is a wrapper around object factory that keeps
// info about type of factory result, type of arguments and scope
//
protocol DependencyEntryType {
    var type: Any.Type { get }
    var argumentsType: Any.Type { get }
    var factory: Any { get }
    var scope: DependencyScope { get }
}

public final class DependencyEntry: DependencyEntryType {
    let type: Any.Type
    let argumentsType: Any.Type

    let factory: Any
    let scope: DependencyScope

    init(type: Any.Type, argumentsType: Any.Type, factory: Any, scope: DependencyScope) {
        self.type = type
        self.argumentsType = argumentsType
        self.factory = factory
        self.scope = scope
    }
}
