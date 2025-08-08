//
//  HeroesQuizView.swift
//  History Republic
//
//  Created by Andy Heredia on 6/8/25.
//
import SwiftUI

struct HeroesQuizView: View {
    var quiz: QuizResponse
    
    // qué eligió el usuario por pregunta
    @State private var selections: [String: String] = [:]
    @State private var showResult = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(quiz.questions, id: \.id) { question in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(question.text)
                            .font(.headline)
                        
                        ForEach(question.options, id: \.self) { option in
                            
                            Button {
                                // solo permite cambiar antes de enviar
                                guard !showResult else { return }
                                selections[question.id] = option
                            } label: {
                                HStack {
                                    Text(option)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    if selections[question.id] == option {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(backgroundColor(for: question, option: option))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(borderColor(for: question, option: option), lineWidth: 1)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Botón de enviar y resultado
                Button(showResult ? "Reiniciar" : "Enviar") {
                    if showResult {
                        // reset
                        selections = [:]
                        showResult = false
                    } else {
                        showResult = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.greendarkandlightmode)
                
                if showResult {
                    let score = quiz.questions.filter { selections[$0.id] == $0.correctAnswer }.count
                    Text(String(localized: "quiz_score_format",
                                defaultValue: "Puntaje: \(score)/\(quiz.questions.count)",
                                comment: "Texto que muestra el puntaje obtenido en un quiz"))
                    .font(.title3.bold())
                    .padding(.top, 8)
                }
            }
            .padding()
            .navigationTitle("🧠 Examen")
        }
    }
    
    // MARK: - Estilos de color
    
    private func backgroundColor(for q: QuestionResponse, option: String) -> Color {
        guard showResult else {
            return selections[q.id] == option ? .gray.opacity(0.2) : .clear
        }
        if option == q.correctAnswer { return .green.opacity(0.2) }
        if selections[q.id] == option { return .red.opacity(0.2) }
        return .clear
    }
    
    private func borderColor(for q: QuestionResponse, option: String) -> Color {
        guard showResult else {
            return selections[q.id] == option ? .gray : .secondary.opacity(0.3)
        }
        if option == q.correctAnswer { return .green }
        if selections[q.id] == option { return .red }
        return .secondary.opacity(0.3)
    }
}

#Preview {
    HeroesQuizView(quiz: QuizResponse(id: "1", title: "Examen", description: "Preparate para realizar un examen de otro nivel mi brother", questions: [QuestionResponse(id: "1", text: "Joan de arco", options: ["Hola", "Como", "Estas"], correctAnswer: "Hola"), QuestionResponse(id: "2", text: "Joan de arco", options: ["Hola", "Como", "Estas"], correctAnswer: "Hola")]))
}
