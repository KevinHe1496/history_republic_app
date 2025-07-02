//
//  FavoriteService.swift
//  History Republic
//
//  Created by Kevin Heredia on 2/7/25.
//

import Foundation

protocol FavoriteServiceProtocol {
    func addFavorite(with idHero: UUID) async throws
}

final class FavoriteService: FavoriteServiceProtocol {
    func addFavorite(with idHero: UUID) async throws {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)/\(idHero)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.addValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        
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
        } catch {
            print("Hubo un error haciendo favorito \(error.localizedDescription)")
        }
    }
}
