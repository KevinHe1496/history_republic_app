//
//  FavoriteView.swift
//  History Republic
//
//  Created by Kevin Heredia on 9/4/25.
//

import SwiftUI

struct FavoriteView: View {
    @State private var viewModel = UserProfileViewModel()
    @State var viewModelHeroes = HeroesViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModelHeroes.favoritesHeroes.isEmpty {
                    ContentUnavailableView("Aún no hay favoritos.", systemImage: "star.slash", description: Text("Agrega algunos elementos a tus favoritos para verlos aquí."))
                } else {
                    
                    List(viewModelHeroes.heroes) { hero in
                        if hero.favoriteHero == true {
                            NavigationLink {
                                HeroDetailView(url: hero.url)
                            } label: {
                                HeroRowView(hero: hero, viewModel: viewModelHeroes)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Favoritos")
            .task {
                try? await viewModelHeroes.fetchAllHeroesWithFavorites()
                // try? await viewModelHeroes.fetchFavoritesHeroes()
            }
            .onReceive(NotificationCenter.default.publisher(for: .kcNotificationrReloadAlumnos)) { _ in
                Task {
                    try? await viewModelHeroes.fetchFavoritesHeroes()
                }
            }
        }
    }
}

#Preview {
    FavoriteView()
}
