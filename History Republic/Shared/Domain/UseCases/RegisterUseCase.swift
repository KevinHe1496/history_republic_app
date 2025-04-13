//
//  RegisterReposotory.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

protocol RegisterUsecaseProtocol {
    var repo: RegisterRepositoryProtocol { get set }
    func registerUser(name: String,email: String, password: String) async throws -> Bool
}

final class RegisterUseCase: RegisterUsecaseProtocol {
    var repo: RegisterRepositoryProtocol
    
    @hrPersistenceKeychain(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    var tokenJWT
    
    init(repo: RegisterRepositoryProtocol = DefaultRegisterRepository()) {
        self.repo = repo
    }
    func registerUser(name: String, email: String, password: String) async throws -> Bool {
        let user = try await repo.registerUser(name: name, email: email, password: password)
        
        if user != "" {
            
            return true
        } else {
            
            return false
        }
    }

}
