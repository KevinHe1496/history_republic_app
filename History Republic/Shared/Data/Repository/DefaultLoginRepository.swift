//
//  DefaultLoginRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

final class DefaultLoginRepository: LoginRepositoryProtocol {
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol = NetworkLogin()) {
        self.Network = Network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        return try await Network.loginApp(user: user, password: password)
    }
}


final class DefaultLoginRepositoryMock: LoginRepositoryProtocol {
    
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol = NetworkLoginMock()) {
        self.Network = Network
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        return try await Network.loginApp(user: user, password: password)
    }
}
