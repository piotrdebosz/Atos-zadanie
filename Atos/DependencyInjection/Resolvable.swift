import Foundation

// Object that implements this protocol can resolve dependencies
//
protocol Resolvable {
    func resolve<Value>(_ type: Value.Type) -> Value
    func resolve<Value, Arg1>(_ type: Value.Type, arg: Arg1.Type) -> Value
}
