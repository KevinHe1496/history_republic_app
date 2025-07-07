//
//  FavoriteServiceRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/7/25.
//
import Foundation

protocol FavoriteServiceRepositoryProtocol {
    func addFavorite(with idHero: UUID) async throws -> Bool
}
