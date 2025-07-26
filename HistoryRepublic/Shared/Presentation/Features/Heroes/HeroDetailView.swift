//
//  HeroDetailView.swift
//  History Republic
//
//  Created by Andy Heredia on 2/7/25.
//

import SwiftUI

struct HeroDetailView: View {
    
    var url: String
    @State private var isLoading = true
    
    var body: some View {
          ZStack {
              if let validURL = URL(string: url) {
                  WebView(url: validURL, isLoading: $isLoading)
                      .edgesIgnoringSafeArea(.all)
              } else {
                  Text("URL inválida")
              }

              if isLoading {
                      ProgressView()
              }
          }
      }
}

#Preview {
    HeroDetailView(url: "https://historyrepublic.com/joan-of-arc/")
}
