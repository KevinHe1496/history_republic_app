
import Foundation

// MARK: - Heroes List
struct HeroResponse: Codable, Identifiable {
    let id: UUID
    var nameHero: String
    var title: String
    var information: String
    var image: String
    var url: String
    var favoriteHero: Bool = false
    
    var imageURL: URL? {
        if let url = URL(string: image) {
            return url
        } else {
            print("No tenia imagen")
            return nil
        }
    }
    
    static let sampleHero = HeroResponse(
        id: UUID(uuidString: "12345678-1234-1234-1234-1234567890AB")!,
        nameHero: "Goku",
        title: "Saiyan Warrior",
        information: "ashiodiasdh asidas0 ashd haishdasiop dhasipodsahidpyais udhjapsd ashd pshd aoshd",
        image: "goku_image", // Suponiendo que es el nombre de una imagen en tus assets
        url: "https://historyrepublic.com/wp-content/uploads/2025/05/St_Olga_by_Nesterov_in_1892.jpg", favoriteHero: false
    )
}

struct HerosLikeRequest: Codable {
    var hero: UUID
}


// MARK: - Heroes List
struct HeroLikeResponse: Codable, Identifiable {
    let id: UUID
    var nameHero: String
    var title: String
    var information: String
    var image: String
    var url: String
    var favoriteHero: Bool = false
    
    var imageURL: URL? {
        if let url = URL(string: image) {
            return url
        } else {
            print("No tenia imagen")
            return nil
        }
    }
    
    static let sampleHero = HeroResponse(
        id: UUID(uuidString: "12345678-1234-1234-1234-1234567890AB")!,
        nameHero: "Goku",
        title: "Saiyan Warrior",
        information: "ashiodiasdh asidas0 ashd haishdasiop dhasipodsahidpyais udhjapsd ashd pshd aoshd",
        image: "goku_image", // Suponiendo que es el nombre de una imagen en tus assets
        url: "https://historyrepublic.com/wp-content/uploads/2025/05/St_Olga_by_Nesterov_in_1892.jpg", favoriteHero: false
    )
}

struct HeroRelationResponse: Codable {
    let id: UUID
    var nameHero: String
    var title: String
    var information: String
    var image: String
    var url: String
    var favoriteHero: Bool = false
    let quiz: QuizResponse
    
    var imageURL: URL? {
        if let url = URL(string: image) {
            return url
        } else {
            print("No tenia imagen")
            return nil
        }
    }
    
}
