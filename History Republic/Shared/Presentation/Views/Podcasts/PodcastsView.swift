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
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    Text("Heroes")
                        .font(.title)
                        .padding(.leading)
                        .padding(.top, 16)
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(viewModel.podcastData, id: \.id) { podcast in
                            NavigationLink {
                                Text("detail")
                            } label: {
                                PodcastRowView(podcasts: podcast)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Podcasts")
            .scrollIndicators(.hidden)
            .toolbar {
                
            }
        }
        
    }
}

#Preview {
    PodcastsView()
        .environment(AppStateVM())
}
