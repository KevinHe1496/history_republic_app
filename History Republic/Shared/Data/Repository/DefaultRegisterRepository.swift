//
//  DefaultRegisterRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

final class DefaultRegisterRepository: RegisterRepositoryProtocol {
    private var network: NetworkRegisterProtocol
    
    init(network: NetworkRegisterProtocol = NetworkRegister()) {
        self.network = network
    }
    
    func registerUser(name: String, email: String, password: String) async throws -> String {
        return try await network.registerUser(name: name, email: email, password: password)
    }
}

final class DefaultRegisterRepositoryMock: RegisterRepositoryProtocol {
    private var network: NetworkRegisterProtocol
    
    init(network: NetworkRegisterProtocol = NetworkRegisterMock()) {
        self.network = network
    }
    
    func registerUser(name: String, email: String, password: String) async throws -> String {
        return try await network.registerUser(name: name, email: email, password: password)
    }
}
