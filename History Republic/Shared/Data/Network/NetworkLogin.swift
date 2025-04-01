//
//  NetworkLogin.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String
}


final class NetworkLogin: NetworkLoginProtocol {
    
    @MainActor
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT = ""
        
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredential = ""
        
        if let credentials = encodeCredentials {
            segCredential = "Basic \(credentials)"
        }
        
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HttpMethods.post
        
        request.addValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.addValue(segCredential, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HttpResponseCodes.SUCESS {
                    let result = try JSONDecoder().decode(LoginResponse.self, from: data)
                    tokenJWT = result.accessToken
                } else {
                    print("Error \(resp.statusCode)")
                }
            }
        } catch {
            tokenJWT = ""
        }
        return tokenJWT
    }
}


final class NetworkLoginMock: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        return UUID().uuidString
    }
}
