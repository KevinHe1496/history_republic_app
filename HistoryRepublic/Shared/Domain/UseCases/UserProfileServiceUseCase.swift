import Foundation

protocol UserProfileServiceUseCaseProtocol {
    var repo: UserProfileServiceRepositoryProtocol { get set }
    func fetchUser() async throws -> UserResponse
    func updateUser(name: String) async throws -> UserRequest
    func deleteUser() async throws
}

final class UserProfileServiceUseCase: UserProfileServiceUseCaseProtocol {
    var repo: UserProfileServiceRepositoryProtocol
    
    init(repo: UserProfileServiceRepositoryProtocol = UserProfileServiceRepository()) {
        self.repo = repo
    }
    
    func fetchUser() async throws -> UserResponse {
        try await repo.fetchUser()
    }
    
    func updateUser(name: String) async throws -> UserRequest {
        try await repo.updateUser(name: name)
    }
    
    func deleteUser() async throws {
        try await repo.deleteUser()
    }
    
    
}
