import Foundation

@Observable
final class UserProfileViewModel {
    var userData: UserResponse = UserResponse(id: "", email: "", favorites: [], name: "")
    
    @ObservationIgnored
    var useCase: UserProfileServiceUseCaseProtocol
    
    init(useCase: UserProfileServiceUseCaseProtocol = UserProfileServiceUseCase()) {
        self.useCase = useCase
        Task {
            try await fetchUser()
        }
    }
    
    @MainActor
    func fetchUser() async throws {
        do {
            let data = try await useCase.fetchUser()
            userData = data
        } catch {
            print("Error en ViewModel o no se")
        }
    }
    
    @MainActor
    func updateUser(name: String) async throws {
        _ =  try await useCase.updateUser(name: name)
    }
    
    @MainActor
    func deleteUser() async throws {
        _ = try await useCase.deleteUser()
    }
    
}
