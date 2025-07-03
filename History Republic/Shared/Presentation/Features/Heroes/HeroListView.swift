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
          
                VStack(spacing: 16) {
                    
                    // Secciónes y Podcasts
                    List(viewModel.heroesData) { hero in
                        
                        NavigationLink {
                            HeroDetailView(url: hero.url)
                        } label: {
                            
                            HeroRowView(heroes: hero)
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Heroes")
        }
    }
}


#Preview {
    HeroListView()
        .environment(AppStateVM())
}
