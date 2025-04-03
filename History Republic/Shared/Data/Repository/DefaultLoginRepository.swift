//
//  DefaultLoginRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

final class DefaultLoginRepository: LoginRepositoryProtocol {
    private var network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol = NetworkLogin()) {
        self.network = network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        return try await network.loginApp(user: user, password: password)
    }
}


final class DefaultLoginRepositoryMock: LoginRepositoryProtocol {
    
    private var network: NetworkLoginProtocol
    
    init(network: NetworkLoginProtocol = NetworkLoginMock()) {
        self.network = network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        return try await network.loginApp(user: user, password: password)
    }
}
