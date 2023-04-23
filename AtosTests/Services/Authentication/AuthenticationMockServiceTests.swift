@testable import Atos
import XCTest

class AuthenticationMockServiceTests: XCTestCase {
    private var authenticationService: AuthenticationMockService!

    override func setUp() {
        super.setUp()
        authenticationService = AuthenticationMockService()
    }

    override func tearDown() {
        authenticationService = nil
        super.tearDown()
    }

    func testLoginSuccess() async {
        let result = await authenticationService.login(login: "Admin", password: "Admin1234")
        switch result {
        case let .success(user):
            XCTAssertEqual(user.userName, "Admin")
            XCTAssertEqual(user.avatarFileName, "Admin.png")
        case .failure:
            XCTFail("Login should have succeeded")
        }
    }

    func testLoginMissingUser() async {
        let result = await authenticationService.login(login: "NonExistentUser", password: "WrongPassword")
        switch result {
        case .success:
            XCTFail("Login should have failed with missing user")
        case let .failure(error):
            XCTAssertEqual(error, AuthenticationError.missingUser)
        }
    }

    func testLoginWrongPassword() async {
        let result = await authenticationService.login(login: "Admin", password: "WrongPassword")
        switch result {
        case .success:
            XCTFail("Login should have failed with wrong password")
        case let .failure(error):
            XCTAssertEqual(error, AuthenticationError.wrongPassword)
        }
    }
}
