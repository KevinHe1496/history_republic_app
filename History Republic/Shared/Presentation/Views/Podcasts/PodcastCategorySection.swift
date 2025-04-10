//
//  PodcastCategorySection.swift
//  History Republic
//
//  Created by Kevin Heredia on 4/4/25.
//

import SwiftUI

struct PodcastCategorySection: View {
    var title: String
    var podcasts: [Podcast]
    var rows: [GridItem]
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) { // Scroll horizontal para esta sección
                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(podcasts) { podcast in
                        NavigationLink {
                            Text(podcast.title)
                        } label: {
                            PodcastRowView(podcasts: podcast)
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
    
    PodcastCategorySection(title: "Heroes", podcasts: [Podcast(airedAt: Date(), imageURL: "https://historyrepublic.com/wp-content/uploads/2025/02/Hannibal.jpg", url: "https://historyrepublic.com/hannibal/", id: UUID().uuidString, title: "Hannibal", descriptionP: "Hannibal Barca was the Carthaginian general who not only challenged Rome at the height of its power but also mesmerized the ancient world by leading war elephants across the towering Alps.")], rows: rows)
}
