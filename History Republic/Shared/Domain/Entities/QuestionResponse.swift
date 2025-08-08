import Foundation

struct QuestionResponse: Codable, Identifiable {
    let id: String
    let text: String
    let options: [String]
    let correctAnswer: String
}
