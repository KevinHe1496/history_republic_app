//
//  PodcastRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol HeroServiceRepositoryProtocol {
    func fetchHeroes() async throws -> [HeroResponse] 
}
