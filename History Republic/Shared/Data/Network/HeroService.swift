//
//  NetworkPodcast.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol HeroServiceProtocol {
    func fetchAllHeroes() async throws -> [HeroResponse]
}

final class HeroService: HeroServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchAllHeroes() async throws -> [HeroResponse] {
        
        var modelReturn = [HeroResponse]()
        
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.heroes.rawValue)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await session.data(for: request)
            
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
            
            let result = try decoder.decode([HeroResponse].self, from: data)
            modelReturn = result
        } catch {
            print("Error in fetch heroes \(error.localizedDescription)")
            throw HRError.errorParsingData
        }
        return modelReturn
    }
}
