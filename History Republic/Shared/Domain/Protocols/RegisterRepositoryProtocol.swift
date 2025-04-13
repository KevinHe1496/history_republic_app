//
//  RegisterRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

protocol RegisterRepositoryProtocol {
    func registerUser(name: String,email: String, password: String) async throws -> String
}
