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
    
    /// Email input from user
    @State private var email = "andy_heredia2008@hotmail.com"
    
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
                    Text("Login to your Account")
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
                        placeholder: "Password",
                        password: $pass
                    )
                    
                    // MARK: - Sign In Button
                    CustomButton(
                        title: "Sign in",
                        color: .mainBrown
                    ) {
                        appState.loginApp(user: email, pass: pass)
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
                
                // MARK: - Sign Up Prompt (Bottom)
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                    
                    // Navigation to the registration view
                    NavigationLink(destination: RegisterView(appState: appState)) {
                        Text("Sign Up here")
                            .foregroundStyle(.mainBrown)
                            .underline()
                    }
                }
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
    LoginView()
        .environment(AppStateVM())
}
