//
//  LoginUserCase.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

protocol LoginUserCaseProtocol {
    var repo: LoginRepositoryProtocol { get set }
    
    func loginApp(user: String, password: String) async throws -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
    
}

final class LoginUserCase: LoginUserCaseProtocol {
  
    var repo:  LoginRepositoryProtocol
    
    @hrPersistenceKeychain(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    var tokenJWT
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository()) {
        self.repo = repo
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
