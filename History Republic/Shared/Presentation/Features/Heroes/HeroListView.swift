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
                        List($viewModel.heroes, id: \.id) { $hero in     // ← $viewModel.heroes
                            NavigationLink {
                                HeroDetailView(url: hero.url)
                            } label: {
                                HeroRowView(hero: $hero,                 // ← ahora sí hay $hero
                                            viewModel: viewModel)
                            }
                            
                        }
                        .listStyle(.plain)
                        
                    }
                    .navigationTitle("Heroes")
                case .error(let message):
                    ErrorLoadingView(message: message, viewModel: viewModel)
                }
            }
            .task {
                try? await viewModel.fetchAllHeroes()
            }
        }
    }
}


#Preview {
    HeroListView()
        .environment(AppStateVM())
}
