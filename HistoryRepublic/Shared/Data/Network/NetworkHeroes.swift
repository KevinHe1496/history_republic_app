//
//  NetworkPodcast.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol NetworkHeroesProtocol {
    func fetchPodcasts() async throws -> [Heroes]
}

final class HeroService: NetworkHeroesProtocol {
    func fetchPodcasts() async throws -> [Heroes] {
        
        var modelReturn = [Heroes]()
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.podcasts.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HRError.errorFromApi(statusCode: -1)
            }
            
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                print("StatusCode: \(httpResponse.statusCode)")
                throw HRError.errorFromApi(statusCode: httpResponse.statusCode)
                
            }
            // ayuda a decodifica el airedAt que se convierta en un Date
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let result = try decoder.decode([Heroes].self, from: data)
            modelReturn = result
        } catch {
            print("Error in fetch heroes \(error.localizedDescription)")
        }
        return modelReturn
    }
}
