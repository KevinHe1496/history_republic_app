//
//  Podcast.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

// MARK: - Welcome
struct PodcastResponse: Codable {
    let items: [PodcastDetail]
}

// MARK: - Podcast
struct PodcastDetail: Codable {
    let airedAt: Date
    let category: String
    let imageURL: String
    let url: String
    let id: String
    let title: String
    let descriptionP: String

    enum CodingKeys: String, CodingKey {
        case airedAt, category
        case imageURL = "imageUrl"
        case url, id, title, descriptionP
    }
}
