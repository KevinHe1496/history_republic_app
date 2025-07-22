//
//  CustomTextField.swift
//  History Republic
//
//  Created by Kevin Heredia on 11/4/25.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: LocalizedStringKey
    @Binding var text: String
    var keyboardType: UIKeyboardType
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(.roundedBorder)
            .keyboardType(keyboardType)
            .background(Color(.systemBackground))
            .clipShape(.buttonBorder)
    }
}

#Preview {
    CustomTextField(placeholder: "Email", text: .constant("example@example.com"), keyboardType: .emailAddress)
}
