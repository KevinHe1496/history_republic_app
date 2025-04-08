//
//  PodcastRepositoryProtocol.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol PodcastRepositoryProtocol {
    func fetchPodcast() async throws -> [PodcastCategory] 
}
