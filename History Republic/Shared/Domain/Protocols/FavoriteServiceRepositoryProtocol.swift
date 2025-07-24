//
//  FavoriteServiceRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 23/7/25.
//

import Foundation

protocol FavoriteServiceRepositoryProtocol {
    func addFavorite(with idHero: UUID) async throws
    func removeFavorite(with idHero: UUID) async throws
    func fetchFavorites() async throws -> [HeroResponse]
}
