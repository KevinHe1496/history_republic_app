//
//  PodcastUseCase.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol { get set }
    func fetchHeroes() async throws -> [Heroes]
}

final class PodcastUseCase: HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol
    
    init(repo: HeroesRepositoryProtocol = DefaultPodcastRepository(network: NetworkHeroes())) {
        self.repo = repo
    }
    
    func fetchHeroes() async throws -> [Heroes] {
        return try await repo.fetchHeroes()
    }
}
