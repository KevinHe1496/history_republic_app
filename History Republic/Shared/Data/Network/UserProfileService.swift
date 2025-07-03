import Foundation

protocol UserProfileServiceProtocol {
    func fetchUser() async throws -> UserResponse
    func updateUser(name: String) async throws -> UserRequest
    func deleteUser() async throws
}

final class UserProfileService: UserProfileServiceProtocol {
    func fetchUser() async throws -> UserResponse {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.fetchMe.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse else {
                throw HRError.errorFromApi(statusCode: -1)
            }
            
            guard res.statusCode == HttpResponseCodes.SUCESS else {
                throw HRError.errorFromApi(statusCode: res.statusCode)
            }
            
            return try JSONDecoder().decode(UserResponse.self, from: data)
            
        } catch {
            throw HRError.errorParsingData
        }
    }
    
    func updateUser(name: String) async throws -> UserRequest {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.fetchMe.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        let requestBody = UserRequest(name: name)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.put
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
       
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse else {
                throw HRError.errorFromApi(statusCode: -1)
            }
            
            guard res.statusCode == HttpResponseCodes.SUCESS else {
                throw HRError.errorFromApi(statusCode: res.statusCode)
            }
            
            return try JSONDecoder().decode(UserRequest.self, from: data)
            
        } catch {
            throw HRError.errorParsingData
        }
    }
    
    func deleteUser() async throws {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.fetchMe.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.delete
        
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse else {
                throw HRError.errorFromApi(statusCode: -1)
            }
            
            guard res.statusCode == HttpResponseCodes.SUCESS else {
                throw HRError.errorFromApi(statusCode: res.statusCode)
            }
            
        }
    }
    
    
}
