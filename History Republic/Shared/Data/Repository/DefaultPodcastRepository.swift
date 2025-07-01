//
//  DefaultPodcastRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

final class DefaultPodcastRepository: HeroesRepositoryProtocol {
    private var network: NetworkHeroesProtocol
    
    init(network: NetworkHeroesProtocol = NetworkHeroes()) {
        self.network = network
    }
    
    func fetchHeroes() async throws -> [Heroes] {
        return try await network.fetchPodcasts()
    }
}

