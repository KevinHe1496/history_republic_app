//
//  DefaultPodcastRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

final class HeroServiceRepository: HeroServiceRepositoryProtocol {
    private var network: HeroService
    
    init(network: HeroService = HeroService()) {
        self.network = network
    }
    
    func fetchHeroes() async throws -> [HeroResponse] {
        return try await network.fetchAllHeroes()
    }
    
    func addFavorite(with idHero: UUID) async throws {
        return try await network.addFavorite(with: idHero)
    }
    
    func removeFavorite(with idHero: UUID) async throws {
        return try await network.removeFavorite(with: idHero)
    }
}

