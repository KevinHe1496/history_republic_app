//
//  PodcastViewModel.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

@Observable
final class HeroesViewModel {
    
    var heroesData = [HeroResponse]()

    @ObservationIgnored
    private var podcastUseCase: HeroServiceUseCaseProtocol
    
    
    init(podcastUseCase: HeroServiceUseCaseProtocol = HeroServiceUseCase()){
        self.podcastUseCase = podcastUseCase
        
        Task(priority: .high) {
            try await getCategories()
        }
    }
    
    @MainActor
    func getCategories() async throws {
        let data = try await podcastUseCase.fetchHeroes()
        self.heroesData = data
    }
    
}
