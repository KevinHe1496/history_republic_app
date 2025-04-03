//
//  LoginResponse.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
