//
//  PodcastRowView.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import SwiftUI

struct HeroRowView: View {
    let hero: HeroResponse
    @State private var isFavorite = false
    @State var viewModel: HeroesViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                AsyncImage(url: hero.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 150)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    ProgressView()
                        .tint(.white)
                        .frame(width: 100, height: 150)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(hero.title)
                        .font(.appTitle)
                        .foregroundStyle(.black)
                    
                    Text("Joan of Arc was a teen who helped turn the tide of the Hundred Years’ War.")
                        .font(.appDescription)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            if KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN) != "" {
                Button {
                    isFavorite.toggle()
                    Task {
                       try await viewModel.toggleFavorite(hero.id, current: isFavorite)
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .padding(8)
                        .background(.white.opacity(0.8))
                        .clipShape(Circle())
                        .foregroundStyle(isFavorite ? .red : .gray)
                }
                .buttonStyle(.borderless)
                .padding(8)
            }
        }
    }
}

#Preview {
    HeroRowView(hero: .sampleHero, viewModel: HeroesViewModel())
}
