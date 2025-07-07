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
            switch viewModel.status {
            case .idle, .loading:
                LoadingProgressView()
            case .success(let heroes):
                VStack(spacing: 16) {
                    
                    // Secciónes y Podcasts
                    List(heroes) { hero in
                        
                        NavigationLink {
                            HeroDetailView(url: hero.url)
                        } label: {
                            
                            HeroRowView(hero: hero, viewModel: viewModel)
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Heroes")
            case .error(let message):
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.greenSecondary)
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    CustomButton(title: "Intentar de nuevo", color: .greenSecondary) {
                        Task {
                           try await viewModel.fetchAllHeroes()
                        }
                    }
                }
            }

        }
    }
}


#Preview {
    HeroListView()
        .environment(AppStateVM())
}
