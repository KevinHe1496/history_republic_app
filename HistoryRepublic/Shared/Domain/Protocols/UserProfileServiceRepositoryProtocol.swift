import Foundation

protocol UserProfileServiceRepositoryProtocol {
    func fetchUser() async throws -> UserResponse
    func updateUser(name: String) async throws -> UserRequest
    func deleteUser() async throws
}
