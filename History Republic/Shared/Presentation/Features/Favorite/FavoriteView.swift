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
                List($viewModel.heroes) { $hero in
                    NavigationLink {
                        HeroDetailView(url: hero.url)
                    } label: {
                        HeroRowView(hero: $hero, viewModel: viewModelHeroes)
                    }
                }
                .listStyle(.plain)
            }
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
