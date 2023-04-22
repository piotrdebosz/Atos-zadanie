//
//  DIContainerType.swift
//  Atos
//
//  Created by Piotr Debosz on 22/04/2023.
//

import Foundation

struct InjectIdentifier<Value> {
    private(set) var type: Value.Type? = nil
    private(set) var key: String? = nil
    
    private init(type: Value.Type? = nil, key: String? = nil) {
        self.type = type
        self.key = key
    }
}

extension InjectIdentifier: Hashable {
    public static func ==(lhs: InjectIdentifier, rhs: InjectIdentifier) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        
        if let type = type {
            hasher.combine(ObjectIdentifier(type))
        }
    }
}

protocol Resolvable {
    func resolve<Value>(_ type: Value.Type) -> Value
}

enum DependencyScope {
    case shared
    case transient
}

protocol DIContainerType: AnyObject, Resolvable {
    typealias Factory = (any Resolvable) -> Any
    
    var factories: [AnyHashable: (factory: Factory, scope: DependencyScope)] { get set }
    var sharedDepenedencies: [AnyHashable: Any] { get set }
    
    func register<Value>(_ type: Value.Type, scope: DependencyScope, _ factory: @escaping Factory)
}

extension DIContainerType {
    func register<Value>(_ type: Value.Type, scope: DependencyScope, _ factory: @escaping Factory) {
        let identifier = ObjectIdentifier(type)
        factories[identifier] = (factory: factory, scope: scope)
    }
    
    func resolve<Value>(_ type: Value.Type) -> Value {
        let identifier = ObjectIdentifier(type)
        guard let factory = factories[identifier] else {
            fatalError("You need to register dependency for \(Value.self) first")
        }
                
        switch factory.scope {
        case .transient:
            guard let instance = factory.factory(self) as? Value else {
                fatalError("Cannot create instance of: \(Value.self)")
            }
            
            return instance
        case .shared:
            if let instance = sharedDepenedencies[identifier] as? Value {
                return instance
            }
            
            guard let instance = factory.factory(self) as? Value else {
                fatalError("Cannot create instance of: \(Value.self)")
            }
            
            sharedDepenedencies[identifier] = instance
            
            return instance
            
        }
    }
}
