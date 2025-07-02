//
//  CustomButton.swift
//  History Republic
//
//  Created by Kevin Heredia on 11/4/25.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 22).bold())
                .foregroundStyle(.white)
                .padding(.vertical, 7)
                .frame(maxWidth: .infinity)
                .background(color)
                .clipShape(.buttonBorder)
        }
    }
}

#Preview {
    CustomButton(title: "Login", color: .mainBrown, action: {})
}
