//
//  LoadingView.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.greenSecondaryColor
                .ignoresSafeArea()
            VStack {
                
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
                    .padding()
                
                Text("Loading...")
                    .foregroundStyle(.white)
                    .opacity(isAnimating ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: isAnimating)
            }
            .onAppear {
                isAnimating = true
            }
            
        }
    }
}

#Preview {
    LoadingView()
}
