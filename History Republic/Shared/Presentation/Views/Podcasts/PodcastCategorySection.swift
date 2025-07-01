//
//  PodcastCategorySection.swift
//  History Republic
//
//  Created by Kevin Heredia on 4/4/25.
//

import SwiftUI

struct PodcastCategorySection: View {
    var title: String
    var heroes: [Heroes]
    var rows: [GridItem]
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) { // Scroll horizontal para esta sección
                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(heroes) { hero in
                        NavigationLink {
                            Text(hero.title)
                        } label: {
                            PodcastRowView(heroes: hero)
                        }
                    }
                }
            }
        } header: {
            Text(title)
                .font(.title)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    let rows = [
        GridItem(.fixed(150))
    ]
    
    PodcastCategorySection(title: "Hola", heroes: [.sampleHero], rows: [GridItem]())
}
