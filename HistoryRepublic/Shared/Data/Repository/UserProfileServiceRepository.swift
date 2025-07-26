import Foundation

final class UserProfileServiceRepository: UserProfileServiceRepositoryProtocol {
    
    var network: UserProfileServiceProtocol
    
    init(network: UserProfileServiceProtocol = UserProfileService()) {
        self.network = network
    }
    
    func fetchUser() async throws -> UserResponse {
        try await network.fetchUser()
    }
    
    func updateUser(name: String) async throws -> UserRequest {
        try await network.updateUser(name: name)
    }
    
    func deleteUser() async throws {
        try await network.deleteUser()
    }
    
}
