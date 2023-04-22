import Foundation

protocol Validator {
    associatedtype Argument

    static func isValid(_ argument: Argument) -> Bool
}
