struct HeroesListScreen: View {
    @StateObject private var vm = HeroesViewModel()

    var body: some View {
        NavigationStack {
            switch vm.status {
            case .idle, .loading:
                LoadingProgressView()

            case .success:
                HeroesListView(heroes: $vm.heroes) { id, newVal in
                    try await vm.toggleFavorite(heroID: id, newValue: newVal)
                }
                .navigationTitle("Héroes")

            case .error(let msg):
                ErrorStateView(message: msg)
            }
        }
    }
}
