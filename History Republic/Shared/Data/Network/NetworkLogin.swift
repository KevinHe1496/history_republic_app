//
//  NetworkLogin.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async throws -> String
}


final class NetworkLogin: NetworkLoginProtocol {
    
    
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
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HRError.errorFromApi(statusCode: -1)
            }
            
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                throw HRError.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
            let result = try JSONDecoder().decode(LoginResponse.self, from: data)
            tokenJWT = result.accessToken
            
        } catch  {
            print("error in fetch \(error.localizedDescription)")
        }
        return tokenJWT
    }
}


final class NetworkLoginMock: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async throws -> String {
        return UUID().uuidString
    }
}
