//
//  DefaultPodcastRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

final class HeroServiceRepository: HeroServiceRepositoryProtocol {
    private var network: HeroServiceProtocol
    
    init(network: HeroServiceProtocol = HeroService()) {
        self.network = network
    }
    
    func fetchHeroes() async throws -> [HeroResponse] {
        return try await network.fetchAllHeroes()
    }
}
