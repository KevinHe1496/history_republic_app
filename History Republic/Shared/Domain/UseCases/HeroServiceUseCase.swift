//
//  PodcastUseCase.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol HeroServiceUseCaseProtocol {
    var repo: HeroServiceRepositoryProtocol { get set }
    func fetchHeroes() async throws -> [HeroResponse]
}

final class HeroServiceUseCase: HeroServiceUseCaseProtocol {
    var repo: HeroServiceRepositoryProtocol
    
    init(repo: HeroServiceRepositoryProtocol = HeroServiceRepository(network: HeroService())) {
        self.repo = repo
    }
    
    func fetchHeroes() async throws -> [HeroResponse] {
        return try await repo.fetchHeroes()
    }
}
