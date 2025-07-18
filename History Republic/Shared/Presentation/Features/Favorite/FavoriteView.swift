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
                if viewModel.userData.favorites.isEmpty {
                    ContentUnavailableView("Aún no hay favoritos.", systemImage: "star.slash", description: Text("Agrega algunos elementos a tus favoritos para verlos aquí."))
                } else {
                    List($viewModel.heroes) { $hero in
                        NavigationLink {
                            HeroDetailView(url: hero.url)
                        } label: {
                            HeroRowView(hero: $hero, viewModel: viewModelHeroes)

                        }
                        .listStyle(.plain)
                    }
                }
              
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Mis Favoritos")
            .onAppear {
                Task {
                    try await viewModel.fetchUser()
                }
            }
        }
    }
}

#Preview {
    FavoriteView()
}
