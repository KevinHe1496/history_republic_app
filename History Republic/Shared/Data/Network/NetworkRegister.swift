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
        
        // 4. Hacer la llamada
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // 5. Verificar que sea 200 OK
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HRError.errorFromApi(statusCode: -1)
        }
        guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
            throw HRError.errorFromApi(statusCode: httpResponse.statusCode)
        }
        
        // 6. Decodificar el token
        let decodedResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
        let token = decodedResponse.accessToken
        
        // 8. Devolver el token
        return token
    }
}
