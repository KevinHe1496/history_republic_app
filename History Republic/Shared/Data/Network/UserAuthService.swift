//
//  NetworkRegister.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

protocol AuthServiceProtocol {
    func registerUser(name: String,email: String, password: String) async throws -> String
    func loginApp(user: String, password: String) async throws -> String
}


final class UserAuthService: AuthServiceProtocol {
    
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
        
        let response: AuthTokenResponse = try await NetworkService().sendRequest(request, decodeTo: AuthTokenResponse.self)
        
        let token = response.accessToken
        return token
    }
    
    func loginApp(user: String, password: String) async throws -> String {
        
        var tokenJWT = ""
        
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.login.rawValue)"
        
        
        guard let url = URL(string: urlCad) else {
            throw HRError.badUrl
        }
        
        guard let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString() else {
            throw HRError.authenticationFailed
        }

        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.addValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.addValue("Basic \(encodeCredentials)", forHTTPHeaderField: "Authorization")
        
        
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HRError.errorFromApi(statusCode: -1)
            }
            
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                throw HRError.errorFromApi(statusCode: httpResponse.statusCode)
            }
        do {
            let result = try JSONDecoder().decode(AuthTokenResponse.self, from: data)
            tokenJWT = result.accessToken
        } catch  {
            print("error in fetch \(error.localizedDescription)")
        }
        return tokenJWT
    }
    
}
