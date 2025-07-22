import SwiftUI

struct HeroRowView: View {
    @Binding var hero: HeroResponse
    @State var viewModel: HeroesViewModel

    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 16) {
                
                // Imagen del héroe
                AsyncImage(url: hero.imageURL) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 150)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(hero.title)
                        .font(.appTitle)
                        .foregroundColor(.primary)
                    
                    Text(hero.information)
                        .font(.appDescription)
                        .foregroundColor(.secondary)
                        .lineLimit(4)
                }

                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            )
            
            // Botón en esquina superior derecha
            if !KeyChainHR().loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN).isEmpty {
                VStack {
                    HStack {
                        Spacer()
                        FavoriteButton(isFavorite: $hero.favoriteHero) { newValue in
                            Task {
                                try await viewModel.toggleFavorite(heroID: hero.id,
                                                                   newValue: newValue)
                            }
                        }
                        .padding(8)
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 170)
    }
}





#Preview {
    HeroRowView(hero: .constant(.sampleHero), viewModel: HeroesViewModel())
}
