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
    @State private var showUserProfile = false
    
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
                    
                    // Secciónes y Podcasts
                    Section {
                        ForEach(viewModel.categoriesData) { category in
                            PodcastCategorySection(title: category.name, podcasts: category.podcasts , rows: rows)
                        }
                    }
                }
                .navigationTitle("Podcasts")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showUserProfile = true
                    } label: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.greenSecondaryColor)
                            .padding()
                            .background(
                                Circle()
                                    .stroke(Color.greenSecondaryColor, lineWidth: 1.5)
                                    .frame(width: 32, height: 32)
                            )
                        
                    }
                }
            }
            .sheet(isPresented: $showUserProfile) {
                UserProfileView()
            }
        }
    }
}

#Preview {
    PodcastsView()
        .environment(AppStateVM())
}
