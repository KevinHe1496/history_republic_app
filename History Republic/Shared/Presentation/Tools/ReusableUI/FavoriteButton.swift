//
//  FavoriteButton.swift
//  History Republic
//
//  Created by Kevin Heredia on 7/7/25.
//


// FavoriteButton.swift
import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    var onToggle: ((Bool) -> Void)? = nil
    @State private var animate = false

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                isFavorite.toggle()
                animate = true
                onToggle?(isFavorite)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                animate = false
            }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 24))
                .foregroundStyle(.red)
                .padding(8)
                .background(Color.white)
                .clipShape(Circle())
                .scaleEffect(animate ? 1.1 : 1.0)
        }
        .buttonStyle(.borderless)
    }
}
