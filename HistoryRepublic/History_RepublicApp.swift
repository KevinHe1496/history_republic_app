//
//  History_RepublicApp.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import SwiftUI

@main
struct History_RepublicApp: App {
    @State var AppState = AppStateVM()
    @StateObject private var favorites = FavoritesManager()
    @State private var session = SessionStore()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(AppState)
                .environmentObject(favorites)
                .environment(session)
        }
    }
}
