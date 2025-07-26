import Foundation

struct UserResponse: Codable, Identifiable {
    let id: String
    let email: String
    let favorites: [HeroResponse]
    let name: String
    
    static let sampler = UserResponse(id: "1", email: "andy@example.com", favorites: [], name: "Andy Heredia")
}
