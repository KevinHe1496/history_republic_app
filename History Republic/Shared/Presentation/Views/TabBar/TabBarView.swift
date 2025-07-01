//
//  TabBarView.swift
//  History Republic
//
//  Created by Kevin Heredia on 9/4/25.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        // Create a custom appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Use your custom color as the background
        appearance.backgroundColor = UIColor(Color.greenSecondaryColor)
        
        // Selected icon and text: mainBrownColor
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.mainBrownColor)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(Color.mainBrownColor)
        ]
        
        // Unselected icon and text: white
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // Apply appearance to the TabBar
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HeroesView()
            }
            Tab("Favorite", systemImage: "heart.fill") {
                FavoriteView()
            }
            Tab("Game", systemImage: "person.fill") {
                GameView()
                    .padding()
            }
        }
    }
}

#Preview {
    TabBarView()
        .environment(AppStateVM())
}
