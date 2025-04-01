//
//  LoginRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginApp(user: String, password: String) async throws -> String
}
