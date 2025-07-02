import Foundation

struct UserResponse: Codable {
    let id: String
    let email: String
    let favorites: [HeroResponse]
    let name: String
}
