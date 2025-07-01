//
//  PodcastRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol HeroesRepositoryProtocol {
    func fetchHeroes() async throws -> [Heroes] 
}
