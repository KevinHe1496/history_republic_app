import Foundation

struct QuizResponse: Codable {
    let id: String
    let title: String
    let description: String
    let questions: [QuestionResponse]
}
