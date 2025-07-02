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
    private var useCase: HeroServiceUseCaseProtocol
    
    
    init(useCase: HeroServiceUseCaseProtocol = HeroServiceUseCase()){
        self.useCase = useCase
        
        Task(priority: .high) {
            try await fetchAllHeroes()
        }
    }
    
    @MainActor
    func fetchAllHeroes() async throws {
        let data = try await useCase.fetchHeroes()
        self.heroesData = data
    }
    
}
