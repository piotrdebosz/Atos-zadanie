import Foundation

// DependencyContainer stores information about how to initialize object
// by using factory and also shared instances of the objects
//
// You can register new dependency by calling:
// container.register(MyType.self, scope: .shared) { resolver in [construct object] }
//
// You can also resolve dependency by calling:
// container.resolve(MyType.self)
//
// Right now you can only register types with 0 or 1 arguments
// if there is a need for more, you need to add additional factory
// types and methods
//
protocol DependencyContainerType: AnyObject, Resolvable {
    typealias Factory = (any Resolvable) -> Any
    typealias Factory1Arg<Arg1> = ((any Resolvable, Arg1)) -> Any

    var factories: [AnyHashable: DependencyEntryType] { get set }
    var sharedDepenedencies: [AnyHashable: Any] { get set }

    // Register dependency by providing closure that is called when new instance is needed
    func register<Value>(_ type: Value.Type, scope: DependencyScope, _ factory: @escaping Factory)
    func register<Value, Arg1>(_ type: Value.Type, scope: DependencyScope, _ factory: @escaping Factory1Arg<Arg1>)
}

extension DependencyContainerType {
    func register<Value>(_ type: Value.Type, scope: DependencyScope, _ factory: @escaping Factory) {
        let identifier = ObjectIdentifier(type)

        factories[identifier] = DependencyEntry(
            type: Value.self,
            argumentsType: Factory.self,
            factory: factory,
            scope: scope
        )
    }

    func register<Value, Arg1>(_ type: Value.Type, scope: DependencyScope, _ factory: @escaping Factory1Arg<Arg1>) {
        let identifier = ObjectIdentifier(type)

        factories[identifier] = DependencyEntry(
            type: Value.self,
            argumentsType: Factory1Arg<Arg1>.self,
            factory: factory,
            scope: scope
        )
    }

    private func resolve<Value, Arguments>(_ type: Value.Type, invoker: @escaping ((Arguments) -> Any) -> Any) -> Value {
        typealias FactoryType = (Arguments) -> Any

        let identifier = ObjectIdentifier(type)
        let instance = sharedDepenedencies[identifier]

        if instance == nil {
            if let factory = factories[identifier] {
                guard let castedFactory = factory.factory as? FactoryType else {
                    fatalError("Cannot factory to \(FactoryType.self)!")
                }

                let newInstance = invoker(castedFactory)

                if factory.scope == .shared {
                    sharedDepenedencies[identifier] = newInstance
                }

                guard let newInstance = newInstance as? Value else {
                    fatalError("Cannot cast instance to \(Value.self)!")
                }

                return newInstance
            } else {
                fatalError("You need to register dependency for \(Value.self) first!")
            }
        } else {
            guard let instance = instance as? Value else {
                fatalError("Cannot cast instance to \(Value.self)!")
            }

            return instance
        }
    }

    func resolve<Value>(_ type: Value.Type) -> Value {
        return resolve(type) { (factory: Factory) in
            factory(self)
        }
    }

    func resolve<Value, Arg1>(_ type: Value.Type, arg: Arg1) -> Value {
        return resolve(type) { (factory: Factory1Arg<Arg1>) in
            factory((self, arg))
        }
    }
}
