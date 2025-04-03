//
//  PodcastUseCase.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

protocol PodcastUseCaseProtocol {
    var repo: PodcastRepositoryProtocol { get set }
    func fetchPodcasts() async throws -> [PodcastDetail]
}

final class PodcastUseCase: PodcastUseCaseProtocol {
    var repo: PodcastRepositoryProtocol
    
    init(repo: PodcastRepositoryProtocol = DefaultPodcastRepository(network: NetworkPodcast())) {
        self.repo = repo
    }
    
    func fetchPodcasts() async throws -> [PodcastDetail] {
        return try await repo.fetchPodcast()
    }
}


final class PodcastUseCaseMock: PodcastUseCaseProtocol {
    var repo: PodcastRepositoryProtocol
    
    init(repo: PodcastRepositoryProtocol = DefaultPodcastRepository(network: NetworkPodcastMock())) {
        self.repo = repo
    }
    
    func fetchPodcasts() async throws -> [PodcastDetail] {
        return try await repo.fetchPodcast()
    }
}
