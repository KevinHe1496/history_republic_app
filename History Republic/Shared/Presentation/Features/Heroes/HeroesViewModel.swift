//
//  PodcastViewModel.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

@Observable
final class HeroesViewModel {
    
    var status: ViewState<[HeroResponse]> = .idle

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
        status = .loading
        do {
            let data = try await useCase.fetchHeroes()
            status = .success(data)
        } catch {
            status = .error("No se pudo cargar los heroes")
        }
    }
}
