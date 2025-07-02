//
//  HeroDetailView.swift
//  History Republic
//
//  Created by Andy Heredia on 2/7/25.
//

import SwiftUI

struct HeroDetailView: View {
    
    var url: String
    
    var body: some View {
        if url.isEmpty {
            VStack(spacing: 8) {
                ProgressView()
                Text("Cargando información del héroe…")
                    .font(.caption)
                    .foregroundColor(.red)
                    .tint(.red)
            }
            .frame(height: 150)
        } else {
            WebView(url: URL(string: url)!)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

#Preview {
    HeroDetailView(url: "https://historyrepublic.com/joan-of-arc/")
}
