//
//  PodcastsView.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import SwiftUI

struct HeroListView: View {
    @Environment(AppStateVM.self) var appState
    
    @State var viewModel: HeroesViewModel
    @State private var showUserProfile = false
    
    init(viewModel: HeroesViewModel = HeroesViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.status {
                case .idle, .loading:
                    LoadingProgressView()
                case .success:
                    VStack(spacing: 16) {
                        
                        // Secciónes y Podcasts
                        // HeroListView.swift  (solo la parte de la lista)
                        List {
                            ForEach(viewModel.filteredCharacters) { hero in
                                NavigationLink {
                                    HeroDetailView(url: hero.url)
                                } label: {
                                    HeroRowView(hero: hero, viewModel: viewModel)
                                }
                            }
                        }
                        .listStyle(.plain)
                        
                    }
                    .searchable(text: $viewModel.searchText)
                    .navigationTitle("Héroes")
                case .error(let message):
                    ErrorLoadingView(message: message, viewModel: viewModel)
                }
            }
            .onAppear {
                Task {
                    try await viewModel.fetchAllHeroesWithFavorites()
                }
            }
        }
    }
}


#Preview {
    HeroListView()
        .environment(AppStateVM())
}
