//
//  RegisterRequest.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
}

struct RegisterReponse: Codable {
    let accessToken: String
    let refreshToken: String
}
