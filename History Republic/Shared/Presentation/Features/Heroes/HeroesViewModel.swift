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
    var heroes = [HeroResponse]()
    var favoriteHeroSelected: Bool = false
    
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
            heroes = try await useCase.fetchHeroes()
            status = .success(heroes)
        } catch {
            status = .error("No se pudo cargar los heroes")
        }
    }
    
    @MainActor
    func setLike(with heroID: UUID) async throws {
        do {
            _ = try await useCase.addFavorite(with: heroID)
        } catch {
            print("Hubo un error haciendo like al heroe: \(error.localizedDescription)")
        }
    }
    @MainActor
    func removeLike(with heroID: UUID) async throws {
        do {
            _ = try await useCase.removeFavorite(with: heroID)
        } catch {
            print("Hubo un error removiendo el like del hero: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func toggleFavorite(_ id: UUID, current: Bool) async throws {
        guard let idx = heroes.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        heroes[idx].favoriteHero.toggle()
        
        do {
            if current == false {
                try await useCase.removeFavorite(with: id)
            } else {
                try await useCase.addFavorite(with: id)
            }
        } catch {
            // 2️⃣  Si falla, revertir y mostrar alerta
            heroes[idx].favoriteHero = current
            print("Error al cambiar favorito: \(error.localizedDescription)")
            // Podrías usar `@State var alert` para notificar al usuario
        }
    }
    
}
