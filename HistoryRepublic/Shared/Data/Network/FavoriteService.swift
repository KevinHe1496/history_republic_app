//
//  FavoriteService.swift
//  History Republic
//
//  Created by Kevin Heredia on 2/7/25.
//

import Foundation

protocol FavoriteServiceProtocol {
    func addFavorite(with idHero: UUID) async throws -> Bool
    func removeFavorite(with idHero: UUID) async throws -> Bool
    func fetchFavorites() async throws -> [HeroResponse]
}

final class FavoriteService: FavoriteServiceProtocol {

    private let session: URLSession = .shared

    func addFavorite(with idHero: UUID) async throws -> Bool {
        // 1. URL segura
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)/\(idHero.uuidString)"

        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        // 2. Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(HerosLikeRequest(hero: idHero))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // 3. Token
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")

        // 4. Call
        do {
            let (_, response) = try await session.data(for: request)
            
            if (response.getResponseCode() == HttpResponseCodes.SUCCESS_CREATE){
                //Succes
                return true
            }
            return false
        } catch {
            NSLog("Error en like hero: \(error.localizedDescription)")
            return false
        }
     
    }
    
    func removeFavorite(with idHero: UUID) async throws -> Bool {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)/\(idHero.uuidString)"

        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (_, response) = try await session.data(for: request)
            let statusCode = response.getResponseCode()

            return statusCode == HttpResponseCodes.SUCESS
        } catch {
            NSLog("Error al eliminar favorito: \(error.localizedDescription)")
            return false
        }
    }

    

    func fetchFavorites() async throws -> [HeroResponse] {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)"
        
        guard let url = URL(string: urlString) else {
           throw HRError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        let jwtToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        
        // Verifica que la respuesta sea válida y del tipo HTTPURLResponse.
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HRError.errorFromApi(statusCode: -1)
        }
        
        // Valida que el código de respuesta HTTP sea exitoso.
        guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
            throw HRError.errorFromApi(statusCode: httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode([HeroResponse].self, from: data)
            return result
        } catch {
            print("Hubo un error obteniendo los favoritos: \(error.localizedDescription)")
            throw HRError.dataNoReveiced
        }
    }
}


//ejemplo extension
extension URLResponse {
 
    func getResponseCode() -> Int {
        if let resp = self as? HTTPURLResponse {
            return resp.statusCode
        } else{
            return 500
        }
        
    }
    
}
