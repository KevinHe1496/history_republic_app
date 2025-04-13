//
//  NetworkService.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(_ urlRequest: URLRequest, decodeTo type: T.Type) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    func sendRequest<T>(_ urlRequest: URLRequest, decodeTo type: T.Type) async throws -> T where T : Decodable {
        // Hacer la llamada
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 5. Verificar que sea 200 OK
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HRError.errorFromApi(statusCode: -1)
        }
        guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
            throw HRError.errorFromApi(statusCode: httpResponse.statusCode)
        }
        // Decodificamos
        return try JSONDecoder().decode(T.self, from: data)
    }
}
