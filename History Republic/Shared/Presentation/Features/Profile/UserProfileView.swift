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
                                .fill(Color.greenSecondary)
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
                        appState.closeSessionUser()
                    }
                    .foregroundStyle(.greenSecondary)
                    .font(.appButton)
                    Button("Borrar cuenta") {
                       showAlert = true
                    }
                    .font(.appButton)
                    .foregroundStyle(.greenSecondary)
                    .alert("Borrar mi cuenta", isPresented: $showAlert) {
                        Button("Eliminar", role: .destructive) {
                            Task {
                                try await viewModel.deleteUser()
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
