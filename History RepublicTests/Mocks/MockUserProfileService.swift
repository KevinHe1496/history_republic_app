import Foundation

@testable import History_Republic
final class MockUserProfileService: UserProfileServiceProtocol {
    
    var didCallDeleteUser = false
    var didCallUpdateUser = false
    var lastUpdatedUser: String?
    
    func fetchUser() async throws -> UserResponse {
        mockUserProfileResponse()
    }
    
    func updateUser(name: String) async throws -> UserRequest {
        didCallUpdateUser = true
        lastUpdatedUser = name
        return mockUserProfileRequest()
    }
    
    func deleteUser() async throws {
        didCallDeleteUser = true
    }

    
    func mockUserProfileResponse() -> UserResponse {
        return UserResponse(id: "1", email: "andy@example.com", favorites: [], name: "Andy")
    }
    
    func mockUserProfileRequest() -> UserRequest {
        return UserRequest(name: "Andy Heredia")
    }
    
}
