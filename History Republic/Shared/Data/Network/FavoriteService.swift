//
//  FavoriteService.swift
//  History Republic
//
//  Created by Kevin Heredia on 2/7/25.
//

import Foundation

enum FavoriteAction {
    case liked     // ❤️ se marcó como favorito (201)
    case unliked   // 💔 se quitó de favoritos (204)
}

protocol FavoriteServiceProtocol {
    func addFavorite(with idHero: UUID) async throws
    func removeFavorite(with idHero: UUID) async throws
    func fetchFavorites() async throws -> [HeroResponse]
}

final class FavoriteService: FavoriteServiceProtocol {

    private let session: URLSession = .shared

    func addFavorite(with idHero: UUID) async throws  {
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
        let (_, response) = try await session.data(for: request)

        guard let res = response as? HTTPURLResponse,
              res.statusCode == HttpResponseCodes.SUCESS else {
            throw HRError.errorFromApi(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
     
    }
    
    func removeFavorite(with idHero: UUID) async throws {
        //Todo
        // 1. URL segura
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)/\(idHero.uuidString)"

        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        // 4. Call
        let (_, response) = try await session.data(for: request)

        guard let res = response as? HTTPURLResponse,
              res.statusCode == HttpResponseCodes.SUCESS else {
            throw HRError.errorFromApi(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
       
    }
    
    func toggleFavorite(id: UUID) async throws -> FavoriteAction {

        // 1️⃣ Construir URL
        let urlString = "\(ConstantsApp.CONS_API_URL)/api/favorites/\(id.uuidString)"
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }

        // 2️⃣ Crear request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // 3️⃣ Incluir token JWT
        let token = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // 4️⃣ Llamada con URLSession
        let (_, response) = try await URLSession.shared.data(for: request)

        // 5️⃣ Interpretar respuesta HTTP
        guard let res = response as? HTTPURLResponse else {
            throw HRError.errorFromApi(statusCode: -1)
        }

        switch res.statusCode {
        case 201:
            return .liked                  // héroe fue marcado como favorito
        case 204:
            return .unliked                // héroe fue quitado de favoritos
        case 401:
            throw HRError.errorParsingData     // token expirado o ausente
        default:
            throw HRError.errorFromApi(statusCode: res.statusCode)
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
