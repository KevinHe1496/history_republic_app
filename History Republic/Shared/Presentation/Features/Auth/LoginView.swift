//
//  LoginView.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import SwiftUI

/// The login screen of the application.
/// Provides UI for the user to input their credentials and sign in.
/// Uses AppStateVM to manage login logic and application state.
struct LoginView: View {
    
    /// Access to the shared app state view model
    @Environment(AppStateVM.self) var appState
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: UserAuthViewModel
    @State private var herosViewModel = HeroesViewModel()
    
    init(appState: AppStateVM) {
        _viewModel = State(initialValue: UserAuthViewModel(appState: appState))
    }
    
    /// Email input from user
    @State private var email = "kevin@example.com"
    
    /// Password input from user
    @State private var pass = "123456"
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Logo (Top)
                VStack {
                    Image(.logoHR)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        
                }
//                .frame(maxHeight: .infinity, alignment: .top)
                Spacer().frame(height: 100)
                
                // MARK: - Login Form (Center)
                VStack(spacing: 10) {
                    
                    // Title
                    Text("Accede a tu cuenta")
                        .foregroundStyle(.white)
                        .font(.system(size: 26).bold())
                    
                    // Email Field
                    CustomTextField(
                        placeholder: "Email",
                        text: $email,
                        keyboardType: .emailAddress
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
                    // Password Field
                    CustomSecureField(
                        placeholder: "Contraseña",
                        password: $pass
                    )
                    
                    // MARK: - Sign In Button
                    CustomButton(
                        title: "Iniciar sesión",
                        color: .mainBrown
                    ) {
                        Task(priority: .high) {
                            _ = try await viewModel.loginApp(email: email, pass: pass)
                            _ = try await herosViewModel.fetchAllHeroesWithFavorites()
                        }
                        dismiss()
                    }
                    
                    .alert("Mensaje", isPresented: $viewModel.showAlert) {
                        Button("Ok") { }
                    } message: {
                        Text(viewModel.message)
                    }
                  
                    
                    // MARK: - Error Message
                    if let error = appState.loginError {
                        Text(error)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }
                Spacer().frame(height: 200)
//                .frame(maxHeight: .infinity, alignment: .center)
                
//                .frame(maxHeight: .infinity, alignment: .bottom)
//                .padding(.bottom, 30)
            }
           
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.greenSecondary) // Custom background color
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    LoginView(appState: AppStateVM())
        .environment(AppStateVM())
}
