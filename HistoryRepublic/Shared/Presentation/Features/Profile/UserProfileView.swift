//
//  UserProfileView.swift
//  History Republic
//
//  Created by Kevin Heredia on 2/7/25.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AppStateVM.self) var appState
    
    @State var viewModel = UserProfileViewModel()
    @State var showAlert: Bool = false
    @State var herosViewModel = HeroesViewModel()
    
    
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .center) {
                    Text("Perfil")
                        .font(.appTitle)
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(16)
                        .background(
                            Circle()
                                .fill(Color.greendarkandlightmode)
                        )
                    
                    Text(viewModel.userData.name)
                        .font(.appDescription)
                    Text(viewModel.userData.email)
                        .font(.appDescription)
                    
                    
                    
                }
                .frame(maxWidth: .infinity)
                
                Section {
                    NavigationLink("Editar perfil") {
                        EditUserProfileView(name: viewModel.userData.name)
                    }
                    .font(.appDescription)
                    
                    NavigationLink("Condiciones de uso") {
                        TermsOfUseView()
                    }
                    .font(.appDescription)
                }
                
                
                Section {
                    Button("Cerrar sesión") {
                        Task {
                            await appState.closeSessionUser()
                            
                        }
                    }
                    .foregroundStyle(.greendarkandlightmode)
                    .font(.appButton)
                    Button("Borrar cuenta") {
                        showAlert = true
                    }
                    .font(.appButton)
                    .foregroundStyle(.greendarkandlightmode)
                    .alert("Borrar mi cuenta", isPresented: $showAlert) {
                        Button("Eliminar", role: .destructive) {
                            Task {
                                try await appState.deleteAccount()
                            }
                        }
                        
                        Button("Cancelar", role: .cancel) { }
                    } message: {
                        Text("¿Estás seguro que quieres eliminar tu cuenta?")
                    }
                }
            }
            .onAppear {
                Task {
                    try await viewModel.fetchUser()
                }
            }
        }
    }
}

#Preview {
    UserProfileView()
        .environment(AppStateVM())
}
