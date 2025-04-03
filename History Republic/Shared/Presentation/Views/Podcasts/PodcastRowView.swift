//
//  PodcastRowView.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import SwiftUI

struct PodcastRowView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
                 ]
    let podcasts: PodcastDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: podcasts.imageURL) ) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                ProgressView()
                    .tint(.white)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
            VStack {
                Text(podcasts.title)
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    PodcastRowView(podcasts: PodcastDetail(airedAt: Date(), category: "Heroes", imageURL: "https://historyrepublic.com/wp-content/uploads/2025/02/Hannibal.jpg", url: "https://historyrepublic.com/hannibal/", id: UUID().uuidString, title: "Hannibal", descriptionP: "Hannibal Barca was the Carthaginian general who not only challenged Rome at the height of its power but also mesmerized the ancient world by leading war elephants across the towering Alps."))
}
