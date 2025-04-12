//
//  RegisterView.swift
//  History Republic
//
//  Created by Kevin Heredia on 11/4/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var registerNetwork = NetworkRegister()
    
    var body: some View {
        VStack {
            
            // MARK: - Logo (Top)
            VStack {
                Image(.logoHR)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }
            Spacer()
            
            VStack(spacing: 10) {
                CustomTextField(placeholder: "Name", text: $name, keyboardType: .default)
                CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                CustomSecureField(placeholder: "Password", password: $password)
                
                CustomButton(title: "Sign up", color: .mainBrown) {
                    Task{
                        try await registerNetwork.registerUser(name: name, email: email, password: password)
                }

                }
            }
            Spacer()
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.greenSecondary)
    }
}

#Preview {
    RegisterView()
}
