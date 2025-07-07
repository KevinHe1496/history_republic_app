//
//  RegisterReposotory.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

protocol UserAuthServiceUsecaseProtocol {
    var repo: UserAuthServiceRepositoryProtocol { get set }
    func registerUser(name: String,email: String, password: String) async throws -> Bool
    func loginApp(user: String, password: String) async throws -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}

final class UserAuthServiceUseCase: UserAuthServiceUsecaseProtocol {
    var repo: UserAuthServiceRepositoryProtocol
    
    @hrPersistenceKeychain(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    var tokenJWT
    
    init(repo: UserAuthServiceRepositoryProtocol = UserAuthServiceRepository()) {
        self.repo = repo
    }
    func registerUser(name: String, email: String, password: String) async throws -> Bool {
        let token = try await repo.registerUser(name: name, email: email, password: password)
        
        if token != "" {
            tokenJWT = token
            return true
        } else {
            
            return false
        }
    }
    
    func loginApp(user: String, password: String) async throws -> Bool {
        let token = try await repo.loginApp(user: user, password: password)
        
        if token != "" {
            tokenJWT = token
            return true
        } else {
            tokenJWT = ""
            return false
        }
    }
    
    func logout() async {
        KeyChainHR().deleteHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if tokenJWT != "" {
            return true
        } else {
            return false
        }
    }

}
