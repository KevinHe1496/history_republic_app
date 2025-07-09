struct FavoriteRowView: View {
    let hero: HeroResponse
    let onToggle: (Bool) -> Void
    
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
            
            FavoriteButton(isFavorite: .constant(hero.favoriteHero)) {
                onToggle($0)
            }
            .padding(8)
        }
    }
}
