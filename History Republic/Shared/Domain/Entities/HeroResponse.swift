
import Foundation

// MARK: - Heroes List
struct HeroResponse: Codable, Identifiable {
    let id: UUID
    let nameHero: String
    let title: String
    let information: String
    let image: String
    let url: String
    
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
        information: "",
        image: "goku_image", // Suponiendo que es el nombre de una imagen en tus assets
        url: "https://historyrepublic.com/wp-content/uploads/2025/05/St_Olga_by_Nesterov_in_1892.jpg"
    )
}

