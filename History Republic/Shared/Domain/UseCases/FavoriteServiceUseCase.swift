//
//  FavoriteServiceUseCase.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/7/25.
//

import Foundation

protocol FavoriteServiceUseCaseProtocol {
    func addFavorite(with idHero: UUID) async throws
    func removeFavorite(with idHero: UUID) async throws
    func fetchFavorites() async throws -> [HeroResponse]
}

final class FavoriteServiceUseCase: FavoriteServiceUseCaseProtocol{
    private let repo: FavoriteServiceRepositoryProtocol
    
    init(repo: FavoriteServiceRepositoryProtocol = FavoriteServiceRepository()) {
        self.repo = repo
    }
    
    func addFavorite(with idHero: UUID) async throws {
        try await repo.addFavorite(with: idHero)
    }
    
    func removeFavorite(with idHero: UUID) async throws {
        try await repo.removeFavorite(with: idHero)
    }
    
    func fetchFavorites() async throws -> [HeroResponse] {
        try await repo.fetchFavorites()
    }
}
