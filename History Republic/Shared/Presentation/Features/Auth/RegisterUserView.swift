//
//  RegisterView.swift
//  History Republic
//
//  Created by Kevin Heredia on 11/4/25.
//

import SwiftUI

struct RegisterUserView: View {
    @Environment(AppStateVM.self) private var appState
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var showRegisterSuccess = false
    
    @State private var viewModel: UserAuthViewModel
    
    init(appState: AppStateVM) {
        _viewModel = State(initialValue: UserAuthViewModel(appState: appState))
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Logo (Top)
            VStack {
                Image(.logoHR)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }
            .ignoresSafeArea(.keyboard)
            Spacer().frame(height: 50)
            
            VStack(spacing: 10) {
                CustomTextField(placeholder: "Name", text: $name, keyboardType: .default)
                CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                CustomSecureField(placeholder: "Password", password: $password)
                
                CustomButton(title: "Sign up", color: .mainBrown) {
                    Task {
                        try await viewModel.registerUser(name: name, email: email, password: password)
                    }
                    
                }
            }
            Spacer().frame(height: 200)
                .alert("Mensaje", isPresented: $viewModel.showAlert) {
                    Button("OK") { }
                } message: {
                    Text(viewModel.message)
                }
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.greenSecondary)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RegisterUserView(appState: AppStateVM())
        .environment(AppStateVM())
}
