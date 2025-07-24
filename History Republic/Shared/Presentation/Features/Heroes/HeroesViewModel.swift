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
    var isloading: Bool = false
    
    @ObservationIgnored private var useCase: HeroServiceUseCaseProtocol
    @ObservationIgnored var favoriteUseCase: FavoriteServiceUseCaseProtocol
    
    init(
        useCase: HeroServiceUseCaseProtocol = HeroServiceUseCase(),
        favoriteUseCase: FavoriteServiceUseCaseProtocol = FavoriteServiceUseCase()
    ) {
        self.useCase = useCase
        self.favoriteUseCase = favoriteUseCase
        Task {
            try await fetchAllHeroes()
        }
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
    
        @MainActor
        func fetchAllHeroesWithFavorites() async throws {
    
            let allHeroes = try await useCase.fetchHeroes()
            let favorites = try await favoriteUseCase.fetchFavorites()
            let favoriteHeroIDs = favorites.map(\.id)
    
            let updatedHeroes = allHeroes.map { hero in
                var updated = hero
                updated.favoriteHero = favoriteHeroIDs.contains(hero.id)
                return updated
            }
    
            self.heroes = updatedHeroes
            self.status = .success(updatedHeroes)
        }
    
        @MainActor
        func resetFavorites() {
            heroes = heroes.map { hero in
                var h = hero
                h.favoriteHero = false
                return h
            }
        }
    
    //    /// Alterna favorito con actualización optimista
    //    @MainActor
    //    func toggleFavorite(heroID: UUID, newValue: Bool) async throws {
    //        guard let idx = heroes.firstIndex(where: { $0.id == heroID }) else { return }
    //
    //        // ① cambiamos en memoria
    //        heroes[idx].favoriteHero = newValue
    //
    //        do {
    //            _ = try await favoriteUseCase.fetchFavorites()
    //            if newValue {
    //                try await useCase.addFavorite(with: heroID)
    //            } else {
    //                try await useCase.removeFavorite(with: heroID)
    //            }
    //        } catch {
    //            // ② revertimos si falla
    //            heroes[idx].favoriteHero.toggle()
    //            throw error
    //        }
    //    }
    //
    var filteredCharacters: [HeroResponse] {
        heroes
            .filter { searchText.isEmpty || $0.nameHero.localizedCaseInsensitiveContains(searchText) }
            .sorted { $0.nameHero.localizedCaseInsensitiveCompare($1.nameHero) == .orderedAscending }
    }
    
    @MainActor
    func setLikeHero(heroId: UUID) async throws {
        guard let index = heroes.firstIndex(where: { $0.id == heroId }) else {
            NSLog("❌ Héroe no encontrado")
            return
        }
        
        let isCurrentlyFavorite = heroes[index].favoriteHero
        var success = false
        
        do {
            if isCurrentlyFavorite {
                success = try await favoriteUseCase.removeFavorite(with: heroId)
            } else {
                success = try await favoriteUseCase.addFavorite(with: heroId)
            }
            
            if success {
                heroes[index].favoriteHero.toggle()
                NotificationCenter.default.post(
                    name: .kcNotificationrReloadAlumnos,
                    object: "Cambio heroe me gusta"
                )
            } else {
                NSLog("❌ La operación de favorito falló (sin error lanzado)")
            }
            
        } catch {
            NSLog("❌ Error al cambiar favorito: \(error.localizedDescription)")
        }
    }
    
}

extension Notification.Name {
    static let kcNotificationrReloadAlumnos = Notification.Name("ReloadAlumnos")
}
