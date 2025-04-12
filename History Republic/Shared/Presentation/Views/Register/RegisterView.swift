//
//  RegisterView.swift
//  History Republic
//
//  Created by Kevin Heredia on 11/4/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
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
                CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                CustomSecureField(placeholder: "Password", password: $password)
                
                CustomButton(title: "Sign up", color: .mainBrown) {
                    print(email)
                    print(password)
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
