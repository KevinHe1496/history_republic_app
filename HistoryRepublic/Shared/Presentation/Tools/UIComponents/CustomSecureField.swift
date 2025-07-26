//
//  CustomSecureField.swift
//  History Republic
//
//  Created by Kevin Heredia on 11/4/25.
//

import SwiftUI

struct CustomSecureField: View {
    let placeholder: LocalizedStringKey
    @Binding var password: String
    
    var body: some View {
        
        SecureField(placeholder, text: $password)
            .textFieldStyle(.roundedBorder)
            .background(Color(.systemBackground))
            .clipShape(.buttonBorder)
    }
}

#Preview {
    CustomSecureField(placeholder: "Password", password: .constant("example"))
}
