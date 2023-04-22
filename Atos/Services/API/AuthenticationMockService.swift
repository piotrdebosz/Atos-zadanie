//
//  AuthenticationMockService.swift
//  Atos
//
//  Created by Piotr Debosz on 22/04/2023.
//

import Foundation

class AuthenticationMockService: AuthenticationServiceType {
    typealias LoginData = (login: String, password: String)

    private let authenticationData: [LoginData] = [
        (login: "Admin", password: "Admin1234"),
        (login: "Kasia", password: "Kasia1234")
    ]

    private let users: [User] = [
        User(login: "Admin", avatarName: "Admin.png"),
        User(login: "Kasia", avatarName: "Kasia.png")
    ]

    private(set) var currentUser: User?

    func login(login: String, password: String) async -> Result<User, AuthenticationError> {
        guard let userAuthenticationData = authenticationData.first(where: { $0.login == login }) else {
            return .failure(.missingUser)
        }

        guard userAuthenticationData.password == password else {
            return .failure(.wrongPassword)
        }

        let user = findUser(with: login)
        currentUser = user

        return .success(user)
    }

    private func findUser(with login: String) -> User {
        guard let user = users.first(where: { $0.login == login }) else {
            fatalError("User is missing!")
        }

        return user
    }
}
