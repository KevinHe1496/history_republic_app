//
//  PodcastViewModel.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

@Observable
final class PodcastViewModel {
    
    var podcastData = [PodcastDetail]()
    
    @ObservationIgnored
    private var podcastUseCase: PodcastUseCaseProtocol
    
    init(podcastUseCase: PodcastUseCaseProtocol = PodcastUseCase()){
        self.podcastUseCase = podcastUseCase
        
        Task(priority: .high) {
            try await getPodcasts()
        }
    }
    
    @MainActor
    func getPodcasts() async throws {
        let data = try await podcastUseCase.fetchPodcasts()
        self.podcastData = data
    }
}
