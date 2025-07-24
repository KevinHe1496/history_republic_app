//
//  FavoriteServiceRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/7/25.

import Foundation

final class FavoriteServiceRepository: FavoriteServiceRepositoryProtocol {
    
    var network: FavoriteServiceProtocol
    
    init(network: FavoriteServiceProtocol = FavoriteService()) {
        self.network = network
    }
    
    func addFavorite(with idHero: UUID) async throws {
        try await network.addFavorite(with: idHero)
    }
    
    func removeFavorite(with idHero: UUID) async throws {
        try await network.removeFavorite(with: idHero)
    }
    
    func fetchFavorites() async throws -> [HeroResponse] {
        try await network.fetchFavorites()
    }
}
