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
                    Section(header: Text("Heroes").font(.title2).padding()) {
                        ScrollView(.horizontal, showsIndicators: false) { // Scroll horizontal para esta sección
                            LazyHGrid(rows: rows, spacing: 16) {
                                ForEach(viewModel.podcastData.filter { $0.category == "Heroes" }, id: \.id) { podcast in
                                    NavigationLink {
                                        Text("detail")
                                    } label: {
                                        PodcastRowView(podcasts: podcast)
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    // Sección de Battles
                    Section(header: Text("Battles").font(.title2).padding()) {
                        ScrollView(.horizontal, showsIndicators: false) { // Scroll horizontal para esta sección
                            LazyHGrid(rows: rows, spacing: 16) {
                                ForEach(viewModel.podcastData.filter { $0.category == "Battles" }, id: \.id) { podcast in
                                    NavigationLink {
                                        Text("detail")
                                    } label: {
                                        PodcastRowView(podcasts: podcast)
                                    }
                                }
                            }
                        }
                        
                    }
                    
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
