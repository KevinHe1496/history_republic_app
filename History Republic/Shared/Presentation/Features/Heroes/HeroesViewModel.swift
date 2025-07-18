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
    var heroes: [HeroResponse] = []
    var searchText: String = ""

    @ObservationIgnored private var useCase: HeroServiceUseCaseProtocol

    init(useCase: HeroServiceUseCaseProtocol = HeroServiceUseCase()) {
        self.useCase = useCase
        Task { try await fetchAllHeroes() }
    }

    @MainActor
    func fetchAllHeroes() async throws {
        status = .loading
        do {
            heroes = try await useCase.fetchHeroes()
            status = .success(heroes)
        } catch {
            status = .error("No se pudo cargar los héroes")
        }
    }

    /// Alterna favorito con actualización optimista
    @MainActor
    func toggleFavorite(heroID: UUID, newValue: Bool) async throws {
        guard let idx = heroes.firstIndex(where: { $0.id == heroID }) else { return }

        // ① cambiamos en memoria
        heroes[idx].favoriteHero = newValue

        do {
            if newValue {
                try await useCase.addFavorite(with: heroID)
            } else {
                try await useCase.removeFavorite(with: heroID)
            }
        } catch {
            // ② revertimos si falla
            heroes[idx].favoriteHero.toggle()
            throw error
        }
    }

    /// Conveniencia para las vistas
    func isFavorite(heroID: UUID) -> Bool {
        heroes.first(where: { $0.id == heroID })?.favoriteHero ?? false
    }
    
    
    var filteredCharacters: [HeroResponse] {
        if searchText.isEmpty {
            return heroes
        } else {
            return heroes.filter { results in
                results.nameHero.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
