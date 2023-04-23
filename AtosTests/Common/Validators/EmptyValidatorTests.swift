import XCTest
@testable import Atos

class EmptyValidatorTests: XCTestCase {
    func testEmptyValidator_whenStringIsEmpty_returnsFalse() {
        let emptyString = ""

        let result = EmptyValidator.isValid(emptyString)

        XCTAssertFalse(result, "EmptyValidator should return false for an empty string.")
    }

    func testEmptyValidator_whenStringIsNotEmpty_returnsTrue() {
        let nonEmptyString = "Hello, world!"

        let result = EmptyValidator.isValid(nonEmptyString)

        XCTAssertTrue(result, "EmptyValidator should return true for a non-empty string.")
    }

    func testEmptyValidator_whenStringIsNil_returnsFalse() {
        let nilString: String? = nil

        let result = EmptyValidator.isValid(nilString)

        XCTAssertFalse(result, "EmptyValidator should return false for a nil string.")
    }
}
