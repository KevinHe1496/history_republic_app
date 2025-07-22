//
//  ErrorView.swift
//  History Republic
//
//  Created by Kevin Heredia on 11/7/25.
//

import SwiftUI

struct ErrorLoadingView: View {
    var message: String
    var viewModel: HeroesViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundStyle(.greenSecondary)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            CustomButton(title: "Intentar de nuevo", color: .greenSecondary) {
                Task {
                    try await viewModel.fetchAllHeroes()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ErrorLoadingView(message: "Error al cargar la vista", viewModel: HeroesViewModel())
}
