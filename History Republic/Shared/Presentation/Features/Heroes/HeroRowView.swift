//
//  PodcastRowView.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import SwiftUI

struct HeroRowView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
                 ]
    let heroes: HeroResponse
    
    var body: some View {
        HStack() {
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
            VStack(alignment: .leading, spacing: 20) {
                Text(heroes.title)
                    .font(.system(size: 20).bold())
                    .foregroundStyle(.black)
                Text("Joan of Arc fue una joven campesina francesa que lideró ejércitos en la Guerra de los Cien Años.")
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HeroRowView(heroes: .sampleHero)
}
