//
//  TabBarView.swift
//  History Republic
//
//  Created by Kevin Heredia on 9/4/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house.fill") {
                PodcastsView()
            }
            
            Tab("Favorite", systemImage: "heart.fill") {
                FavoriteView()
            }
            
            Tab("Game", systemImage: "gamecontroller.fill") {
                GameView()
            }
        }
    }
}

#Preview {
    TabBarView()
}
