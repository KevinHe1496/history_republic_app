//
//  FavoriteServiceRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 23/7/25.
//

import Foundation

protocol FavoriteServiceRepositoryProtocol {
    func addFavorite(with idHero: UUID) async throws -> Bool
    func removeFavorite(with idHero: UUID) async throws -> Bool
    func fetchFavorites() async throws -> [HeroLikeResponse]
}
