//
//  AuthenticationServiceType.swift
//  Atos
//
//  Created by Piotr Debosz on 22/04/2023.
//

import Foundation

enum AuthenticationError: Swift.Error {
    case missingUser
    case wrongPassword
}

protocol AuthenticationServiceType {
    var currentUser: User? { get }

    func login(login: String, password: String) async -> Result<User, AuthenticationError>
}
