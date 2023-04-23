import Foundation

class EmptyValidator: Validator {
    static func isValid(_ argument: String?) -> Bool {
        guard let argument = argument else {
            return false
        }

        return !argument.isEmpty
    }
}
