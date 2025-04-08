//
//  DefaultPodcastRepository.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/4/25.
//

import Foundation

final class DefaultPodcastRepository: PodcastRepositoryProtocol {
    private var network: NetworkPodcastProtocol
    
    init(network: NetworkPodcastProtocol = NetworkPodcast()) {
        self.network = network
    }
    
    func fetchPodcast() async throws -> [PodcastCategory] {
        return try await network.fetchPodcasts()
    }
}

final class NetworkPodcastMock: NetworkPodcastProtocol {
    func fetchPodcasts() async throws -> [PodcastCategory] {
        
        let model = PodcastCategory(id: UUID(), name: "Heroes", podcasts: [Podcast(airedAt: Date(), imageURL: "https://historyrepublic.com/wp-content/uploads/2025/02/Hannibal.jpg", url: "https://historyrepublic.com/hannibal/", id: UUID().uuidString, title: "Hannibal", descriptionP: "Hannibal Barca was the Carthaginian general who not only challenged Rome at the height of its power but also mesmerized the ancient world by leading war elephants across the towering Alps.")])
        
        let model1 = PodcastCategory(id: UUID(), name: "Heroes", podcasts: [Podcast(airedAt: Date(), imageURL: "https://historyrepublic.com/wp-content/uploads/2025/03/julius-caesar.jpg", url: "https://historyrepublic.com/julius-caesar/", id: UUID().uuidString, title: "Julio Cesar", descriptionP: "Dictador Romano")])
        
        let model2 = PodcastCategory(id: UUID(), name: "Heroes", podcasts: [Podcast(airedAt: Date(), imageURL: "https://historyrepublic.com/wp-content/uploads/2025/02/leonidas_sparta.jpg", url: "https://historyrepublic.com/leonidas-of-sparta/", id: UUID().uuidString, title: "Leonidas of Sparta", descriptionP: "Leonidas of Sparta is a name that echoes through the centuries.")])
        
        
        return [model, model1, model2]
    }
}
