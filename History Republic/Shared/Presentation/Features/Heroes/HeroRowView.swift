//
//  PodcastRowView.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import SwiftUI

struct HeroRowView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
                 ]
    let heroes: HeroResponse
    
    var body: some View {
        HStack {
         
                AsyncImage(url: heroes.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 150)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    ProgressView()
                        .tint(.white)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(heroes.title)
                        .font(.appTitle)
                        .foregroundStyle(.black)
                    Text("Joan of Arc was a teen who helped turn the tide of the Hundred Years’ War.")
                        .font(.appDescription)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal)
            
            
         
                
           
        }
        .padding(.horizontal)
       // .frame(width: 400, height: 500)
    }
}

#Preview {
    HeroRowView(heroes: .sampleHero)
}
