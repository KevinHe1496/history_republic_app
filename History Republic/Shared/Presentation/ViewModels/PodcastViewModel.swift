//
//  PodcastViewModel.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

@Observable
final class PodcastViewModel {
    
    var categoriesData = [PodcastCategory]()
    
    
    @ObservationIgnored
    private var podcastUseCase: PodcastUseCaseProtocol
    
    
    init(podcastUseCase: PodcastUseCaseProtocol = PodcastUseCase()){
        self.podcastUseCase = podcastUseCase
        
        Task(priority: .high) {
            try await getCategories()
        }
    }
    
    @MainActor
    func getCategories() async throws {
        let data = try await podcastUseCase.fetchPodcasts()
        self.categoriesData = data
    }
    
}
