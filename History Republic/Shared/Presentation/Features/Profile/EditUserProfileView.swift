//
//  EditUserProfileView.swift
//  History Republic
//
//  Created by Andy Heredia on 3/7/25.
//

import SwiftUI

struct EditUserProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel = UserProfileViewModel()
    @State var name: String
    @State var showAlert: Bool = false
    
   
    
    var body: some View {
        Form {
            Section("Nombre") {
                TextField("Tu nombre", text: $name)
                    .font(.appDescription)
            }
            Section {
                Button("Guardar Cambios") {
                    showAlert = true
                }
                .font(.appButton)
                .alert("Se ha editado exitosamente", isPresented: $showAlert) {
                    Button("Ok") {
                        Task {
                            try await viewModel.updateUser(name: name)
                            dismiss()
                        }
                    }
                }
                .disabled(name.isEmpty)
            }
            
            .navigationTitle("Editar Perfil")
        }
    }
}

#Preview {
    EditUserProfileView(name: "Andy Heredia")
}
