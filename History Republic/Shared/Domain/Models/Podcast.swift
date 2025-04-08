// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct PodcastCategory: Codable, Identifiable {
    let id: UUID
    let name: String
    let podcasts: [Podcast]
    
}

// MARK: - Podcast
struct Podcast: Codable, Identifiable {
    let airedAt: Date
    let imageURL: String
    let url: String
    let id: String
    let title: String
    let descriptionP: String
    
    enum CodingKeys: String, CodingKey {
        case id, descriptionP, airedAt
        case imageURL = "imageUrl"
        case url, title
    }
}

typealias Welcome = [PodcastCategory]
