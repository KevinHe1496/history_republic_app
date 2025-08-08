import Foundation

struct QuizResponse: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let questions: [QuestionResponse]
    
    static let sampler = QuizResponse(id: "1", title: "asd", description: "asd", questions: [])
}
