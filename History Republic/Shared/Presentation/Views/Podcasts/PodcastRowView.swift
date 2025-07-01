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
    let heroes: Heroes
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: heroes.imageURL) { image in
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
                Text(heroes.title)
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    PodcastRowView(heroes: .sampleHero)
}
