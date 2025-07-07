//
//  NetworkPodcast.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol HeroServiceProtocol {
    func fetchAllHeroes() async throws -> [HeroResponse]
    func addFavorite(with idHero: UUID) async throws
    func removeFavorite(with idHero: UUID) async throws
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
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("StatusCode: \(httpResponse.statusCode)")
                throw HRError.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
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
    
    func addFavorite(with idHero: UUID) async throws {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)/\(idHero)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Token
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")
        
        // Call
        do {
            let (_, response) = try await session.data(for: request)
            
            if let res = response as? HTTPURLResponse {
                if !(200...299).contains(res.statusCode) {
                    throw HRError.errorFromApi(statusCode: res.statusCode)
                }
            } else {
                throw HRError.errorFromApi(statusCode: -1)
            }
            
        } catch {
            NSLog("Error en like hero: \(error.localizedDescription)")
            throw error
        }
    }
    
    func removeFavorite(with idHero: UUID) async throws {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(EndPoints.addFavorite.rawValue)/\(idHero.uuidString)"
        
        guard let url = URL(string: urlString) else {
            throw HRError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let jwToken = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.setValue("Bearer \(jwToken)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await session.data(for: request)
        
        guard let res = response as? HTTPURLResponse,
              (200...299).contains(res.statusCode) else {
            throw HRError.errorFromApi(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
    }
}
