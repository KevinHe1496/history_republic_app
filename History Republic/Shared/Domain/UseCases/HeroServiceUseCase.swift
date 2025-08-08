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
    func fetchAllHeroesWithRelations() async throws -> [HeroRelationResponse]
    func addFavorite(with idHero: UUID) async throws
    func removeFavorite(with idHero: UUID) async throws
}

final class HeroServiceUseCase: HeroServiceUseCaseProtocol {
    var repo: HeroServiceRepositoryProtocol
    
    init(repo: HeroServiceRepositoryProtocol = HeroServiceRepository(network: HeroService())) {
        self.repo = repo
    }
    
    func fetchHeroes() async throws -> [HeroResponse] {
        return try await repo.fetchHeroes()
    }
    
    func fetchAllHeroesWithRelations() async throws -> [HeroRelationResponse] {
        return try await repo.fetchAllHeroesWithRelations()
    }
    
    func addFavorite(with idHero: UUID) async throws {
        return try await repo.addFavorite(with: idHero)
    }
    
    func removeFavorite(with idHero: UUID) async throws {
        return try await repo.removeFavorite(with: idHero)
    }

}
