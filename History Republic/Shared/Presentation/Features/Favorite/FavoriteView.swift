//
//  FavoriteView.swift
//  History Republic
//
//  Created by Kevin Heredia on 9/4/25.
//

import SwiftUI

struct FavoriteView: View {
    @State private var viewModel = UserProfileViewModel()
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.userData.favorites.isEmpty {
                    ContentUnavailableView("Aún no hay favoritos", systemImage: "star.slash", description: Text("Agrega algunos elementos a tus favoritos para verlos aquí."))
                } else {
                    List(viewModel.userData.favorites) { hero in
                        NavigationLink {
                            HeroDetailView(url: hero.url)
                        } label: {
                            ZStack(alignment: .topTrailing) {
                                HStack {
                                    AsyncImage(url: hero.imageURL) { image in
                                        image.resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 100, height: 150)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(hero.title)
                                            .font(.appTitle)
                                        Text(hero.information)
                                            .font(.appDescription)
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
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
