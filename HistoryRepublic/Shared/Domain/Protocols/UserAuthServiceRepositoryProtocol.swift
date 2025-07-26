//
//  RegisterRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

protocol UserAuthServiceRepositoryProtocol {
    func registerUser(name: String,email: String, password: String) async throws -> String
    func loginApp(user: String, password: String) async throws -> String
}
