//
//  LoginView.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(AppStateVM.self) var appState
    
    @State private var email = "andy_heredia2008@hotmail.com"
    @State private var pass = "123456"

    var body: some View {
        NavigationStack {
            ZStack {
                //MARK: Background Color
                Color.greenSecondaryColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    // MARK: History Republic Image
                    Image(.logoHR)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .offset(y: 40)
                        
                    
                    Spacer()
                    
                    
                    Text("Login to your Account")
                        .foregroundStyle(.white)
                        .font(.system(size: 26).bold())
                    
                    
                    // MARK: Login form
                    VStack(spacing: 30) {
                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .font(.system(size: 12))
                            
                        
                        SecureField("Password", text: $pass)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 12))
                        
                        //MARK: Sign in button
                        Button {
                            appState.loginApp(user: email, pass: pass)
                        } label: {
                            Text("Sign in")
                                
                                .font(.system(size: 22).bold())
                                .foregroundStyle(.white)
                                .padding(.vertical, 7)
                                .frame(maxWidth: .infinity)
                                .background(.mainBrownColor)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text("Forgot your password?")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    .padding(16)
                    
                    Spacer()
                    
                    Text("Don't have an account? Sign up.")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
            }
        }

    }
}

#Preview {
    LoginView()
        .environment(AppStateVM())
}
