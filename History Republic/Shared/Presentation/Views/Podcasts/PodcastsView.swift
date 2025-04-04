//
//  PodcastsView.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import SwiftUI

struct PodcastsView: View {
    @Environment(AppStateVM.self) var appState
    
    @State var viewModel: PodcastViewModel
    
    let rows = [
        GridItem(.fixed(150))
    ]
    
    init(viewModel: PodcastViewModel = PodcastViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView { // Scroll principal para todo el contenido
                VStack(spacing: 16) {
                    
                    // Sección de Heroes
                    PodcastCategorySection(title: "Heroes", podcasts: viewModel.podcastData.filter { $0.category == "Heroes" }, rows: rows)
                    
                    
                    // Sección de Battles
                    PodcastCategorySection(title: "Battles", podcasts: viewModel.podcastData.filter { $0.category == "Battles" }, rows: rows)
                    
                    // Agrega más secciones aquí según lo necesites
                }
            }
            .navigationTitle("Podcasts")
            .toolbar {
                Button {
                    self.appState.closeSessionUser()
                } label: {
                    Label("LogOut", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        
    }
}

#Preview {
    PodcastsView()
        .environment(AppStateVM())
}
