import Foundation

struct QuestionResponse: Codable {
    let id: String
    let text: String
    let options: [String]
    let correctAnswer: String
}
