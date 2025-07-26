//
//  DefaultRegisterRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

final class UserAuthServiceRepository: UserAuthServiceRepositoryProtocol {
    private var network: AuthServiceProtocol
    
    init(network: AuthServiceProtocol = UserAuthService()) {
        self.network = network
    }
    
    func registerUser(name: String, email: String, password: String) async throws -> String {
        return try await network.registerUser(name: name, email: email, password: password)
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        return try await network.loginApp(user: user, password: password)
    }
}

