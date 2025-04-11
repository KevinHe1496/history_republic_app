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

                
                VStack {
                    
                    // MARK: History Republic Image
                    VStack {
                        Image(.logoHR)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                            .offset(y: 40)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)

                
                    // MARK: Login form
                    VStack(spacing: 10) {
                        
                        Text("Login to your Account")
                            .foregroundStyle(.white)
                            .font(.system(size: 26).bold())
                        
                        CustomTextField(
                            placeholder: "Email",
                            text: $email,
                            keyboardType: .emailAddress
                        )
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        
                        CustomSecureField(
                            placeholder: "Password",
                            password: $pass
                        )
                        
                        //MARK: Sign in button
                        CustomButton(
                            title: "Sign in",
                            color: .mainBrown
                        ) {
                            appState
                                .loginApp(
                                    user: email,
                                    pass: pass
                                )
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                    
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                        
                        // Navigation to registration view
                        NavigationLink(destination: RegisterView()) {
                            Text("Sign Up here")
                                .foregroundStyle(.mainBrown)
                                .underline()
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 30)
                }
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.greenSecondary)
            }
        }
}

#Preview {
    LoginView()
        .environment(AppStateVM())
}
