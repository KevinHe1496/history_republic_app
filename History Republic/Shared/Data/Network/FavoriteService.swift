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
    private let session: URLSession = .shared

    func addFavorite(with idHero: UUID) async throws {
        // 1. URL segura
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)/\(idHero.uuidString)"

        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        // 2. Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
}
