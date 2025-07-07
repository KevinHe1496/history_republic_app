//
//  UserProfileServiceUseCaseTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 7/7/25.
//

import XCTest

@testable import History_Republic
final class UserProfileServiceUseCaseTests: XCTestCase {
    
    var mockUserProfile: MockUserProfileService!
    var repository: UserProfileServiceRepository!
    var useCase: UserProfileServiceUseCase!
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockUserProfile = MockUserProfileService()
        repository = UserProfileServiceRepository(network: mockUserProfile)
        useCase = UserProfileServiceUseCase(repo: repository)
        
    }

    override func tearDownWithError() throws {
       
        mockUserProfile = nil
        repository = nil
        useCase = nil
        
        try super.tearDownWithError()
    }

    func test_FetchUser_ShouldReturnUser_WhenSuccesful() async throws {
            // Act
            let user = try await useCase.fetchUser()
            // Assert
            XCTAssertNotNil(user, "The fetched user should not be nil")
            XCTAssertEqual(user.email, "andy@example.com", "The user's email should match the expected value")
            XCTAssertEqual(user.id, "1", "The user's ID should match the expected value")
            XCTAssertEqual(user.name, "Andy", "The user's name should match the expected value")
        }
        
        
        func test_DeleteUser_ShouldDeleteUser_WhenSuccesful() async throws {
            // Act
            try await useCase.deleteUser()
            // Assert
            XCTAssertTrue(mockUserProfile.didCallDeleteUser, "The deleteUser function should be called successfully")
        }
        
        func test_UpdateUser_callsServiceWithCorrectModel() async throws {
            
            // Act
            let result = try await useCase.updateUser(name: "Jesse Heredia")
            // Assert
            XCTAssertEqual(result.name, "Andy Heredia", "The original user's name should be 'Andy Heredia'")
            XCTAssertEqual(mockUserProfile.lastUpdatedUser, "Jesse Heredia", "The updated user's name should be 'Jesse Heredia'")
        }

}
