//
//  NetworkRegister.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

protocol NetworkRegisterProtocol {
    func registerUser(name: String,email: String, password: String) async throws -> String
}


final class NetworkRegister: NetworkRegisterProtocol {
    
    func registerUser(name: String, email: String, password: String) async throws -> String {
        // 1. Armar la URL
        guard let url = URL(string: "\(ConstantsApp.CONS_API_URL)\(EndPoints.register.rawValue)") else {
            throw HRError.badUrl
        }
        // 2. Crear el cuerpo de la request
        let requestBody = RegisterRequest(name: name, email: email, password: password)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        // 3. Configurar la petición
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.setValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.httpBody = jsonData
        
        let response: RegisterResponse = try await NetworkService().sendRequest(request, decodeTo: RegisterResponse.self)
        
        let token = response.accessToken
        return token
    }
}

final class NetworkRegisterMock: NetworkRegisterProtocol {
    func registerUser(name: String, email: String, password: String) async throws -> String {
        return UUID().uuidString
    }
}
