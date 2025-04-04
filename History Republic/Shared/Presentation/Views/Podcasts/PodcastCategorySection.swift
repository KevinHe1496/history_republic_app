//
//  PodcastCategorySection.swift
//  History Republic
//
//  Created by Kevin Heredia on 4/4/25.
//

import SwiftUI

struct PodcastCategorySection: View {
    var title: String
    var podcasts: [PodcastDetail]
    var rows: [GridItem]
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) { // Scroll horizontal para esta sección
                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(podcasts, id: \.id) { podcast in
                        NavigationLink {
                            Text("detail")
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
//
//#Preview {
//    PodcastCategorySection(title: "Hannibal", podcasts: [PodcastResponse], rows: <#[GridItem]#>)
//}
