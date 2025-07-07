//
//  PodcastRowView.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import SwiftUI

struct HeroRowView: View {
    @Binding var hero: HeroResponse          // ← enlace directo
    @State var viewModel: HeroesViewModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                AsyncImage(url: hero.imageURL) { image in
                    image.resizable()
                         .scaledToFill()
                         .frame(width: 100, height: 150)
                         .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 150)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(hero.title)
                        .font(.appTitle)
                    Text(hero.information)
                        .font(.appDescription)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)

            // ❤️ Botón favorito
            if !KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN).isEmpty {
                FavoriteButton(isFavorite: $hero.favoriteHero) { newValue in
                    Task {
                        try await viewModel.toggleFavorite(heroID: hero.id,
                                                           newValue: newValue)
                    }
                }
                .padding(8)
            }
        }
    }
}



#Preview {
    HeroRowView(hero: .constant(.sampleHero), viewModel: HeroesViewModel())
}
