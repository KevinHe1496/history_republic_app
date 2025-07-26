//
//  FavoritesManager.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/7/25.
//

import Foundation
import SwiftUI

final class FavoritesManager: ObservableObject {
    @Published private(set) var ids: Set<UUID>          // IDs favoritos en memoria
    private let key = "favoriteHeroIDs"                 // Clave en UserDefaults
    
    init() {
        // 1. Cargar favoritos guardados al iniciar la app
        if let data = UserDefaults.standard.data(forKey: key),
           let saved = try? JSONDecoder().decode([UUID].self, from: data) {
            ids = Set(saved)
        } else {
            ids = []
        }
    }
    
    // 2. Alternar estado de favorito y persistir
    func toggle(id: UUID) {
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
        save()
    }
    
    /// Elimina directamente un favorito si existe
    func delete(id: UUID) {
        if ids.remove(id) != nil {
            save()
        }
    }

    /// Limpia todos los favoritos
    func clearAll() {
        ids.removeAll()
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(Array(ids)) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
