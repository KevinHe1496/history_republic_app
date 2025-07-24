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
    var favoritesHeroes = [HeroResponse]()
    
    @ObservationIgnored private var useCase: HeroServiceUseCaseProtocol
    @ObservationIgnored var favoriteUseCase: FavoriteServiceUseCaseProtocol
    
    init(
        useCase: HeroServiceUseCaseProtocol = HeroServiceUseCase(),
        favoriteUseCase: FavoriteServiceUseCaseProtocol = FavoriteServiceUseCase()
    ) {
        self.useCase = useCase
        self.favoriteUseCase = favoriteUseCase
        Task {
            try await fetchAllHeroesWithFavorites()
        }
    }
    
    @MainActor
    func fetchAllHeroes() async throws {
        status = .loading
        do {
            let heros = try await useCase.fetchHeroes()
            status = .success(heros)
        } catch {
            status = .error(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchFavoritesHeroes() async throws {
        do {
            let heroes = try await favoriteUseCase.fetchFavorites()
            favoritesHeroes = heroes
        }catch {
            print("No pudimos encontrar heroes favoritos")
        }
    }
    
    
    @MainActor
    func fetchAllHeroesWithFavorites() async throws {
        status = .loading
        
        do {
            // 1️⃣ Obtener todos los héroes
            let allHeroes = try await useCase.fetchHeroes()
            
            // 2️⃣ Inicializar arreglo actualizado
            var updatedHeroes = allHeroes
            
            // 3️⃣ Verificar si el usuario tiene un token JWT guardado
            let token = KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
            
            if !token.isEmpty {
                // 4️⃣ Si hay token, cargar favoritos del usuario autenticado
                let favorites = try await favoriteUseCase.fetchFavorites()
                favoritesHeroes = favorites
                let favoriteHeroIDs = Set(favorites.map(\.id)) // Mejora de rendimiento con Set
                
                updatedHeroes = allHeroes.map { hero in
                    var updated = hero
                    updated.favoriteHero = favoriteHeroIDs.contains(hero.id)
                    return updated
                }
            } else {
                // 5️⃣ Si no hay token, marcamos todos como no favoritos
                updatedHeroes = allHeroes.map { hero in
                    var updated = hero
                    updated.favoriteHero = false
                    return updated
                }
            }
            
            // 6️⃣ Actualizar estado
            self.heroes = updatedHeroes
            self.status = .success(updatedHeroes)
            
        } catch {
            NSLog("❌ Error al cargar héroes o favoritos: \(error.localizedDescription)")
            self.favoritesHeroes = []
            self.heroes = []
            self.status = .error("No se pudo cargar los héroes")
            throw error
        }
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
    func setLikeHeroFromHeroes(heroId: UUID) async throws {
        guard let index = heroes.firstIndex(where: { $0.id == heroId }) else {
            NSLog("❌ Héroe no encontrado en heroes")
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
                    object: "Cambio desde vista general"
                )
            } else {
                NSLog("❌ La operación de favorito falló (heroes)")
            }
        } catch {
            NSLog("❌ Error en heroes: \(error.localizedDescription)")
        }
    }

    @MainActor
    func setLikeHeroFromFavorites(heroId: UUID) async throws {
        guard let index = favoritesHeroes.firstIndex(where: { $0.id == heroId }) else {
            NSLog("❌ Héroe no encontrado en favoritos")
            return
        }

        var hero = favoritesHeroes[index]
        let isCurrentlyFavorite = hero.favoriteHero
        var success = false

        do {
            if isCurrentlyFavorite {
                success = try await favoriteUseCase.removeFavorite(with: heroId)
            } else {
                success = try await favoriteUseCase.addFavorite(with: heroId)
            }

            if success {
                // 1. Eliminar de la lista de favoritos si hizo dislike
                if isCurrentlyFavorite {
                    favoritesHeroes.remove(at: index)
                } else {
                    hero.favoriteHero = true
                    favoritesHeroes[index] = hero
                }

                NotificationCenter.default.post(
                    name: .kcNotificationrReloadAlumnos,
                    object: "Cambio desde favoritos"
                )
            } else {
                NSLog("❌ La operación de favorito falló (favorites)")
            }
        } catch {
            NSLog("❌ Error en favoritos: \(error.localizedDescription)")
        }
    }

    
    
}

//    @MainActor
//    func setLikeHero(heroId: UUID) async throws {
//        //llamo al server
//        if (try await favoriteUseCase.addFavorite(with: heroId) == true) {
//            if let index = heroes.firstIndex(where: {$0.id == heroId}){
//                heroes[index].favoriteHero.toggle()
//            }
//        } else {
//            NSLog("Error al llamar me gusta")
//        }
//
//        //Notificamos
//        NotificationCenter.default.post(name: .kcNotificationrReloadAlumnos, object: "Cambio heroe me gusta")
//    }
//}


extension Notification.Name {
    static let kcNotificationrReloadAlumnos = Notification.Name("ReloadAlumnos")
}
