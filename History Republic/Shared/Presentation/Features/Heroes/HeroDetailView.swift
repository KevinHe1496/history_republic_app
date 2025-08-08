//
//  HeroDetailView.swift
//  History Republic
//
//  Created by Andy Heredia on 2/7/25.
//

import SwiftUI

struct HeroDetailView: View {
    
    var url: String
    var quiz: QuizResponse
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
          .toolbar {
              ToolbarItem {
                  NavigationLink {
                      HeroesQuizView(quiz: quiz)
                  } label: {
                      Text("¡A jugar!")
                  }
              }
          }
      }
}

#Preview {
    HeroDetailView(url: "https://historyrepublic.com/joan-of-arc/", quiz: QuizResponse(id: "1", title: "Examen", description: "Preparate para realizar un examen de otro nivel mi brother", questions: [QuestionResponse(id: "1", text: "Joan de arco", options: ["Hola", "Como", "Estas"], correctAnswer: "Hola")]))
}
