//
//  UserProfileViewModelTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 7/7/25.
//

import XCTest

@testable import History_Republic
final class UserProfileViewModelTests: XCTestCase {
    
    var mockUserProfile: MockUserProfileService!
    var repository: UserProfileServiceRepository!
    var useCase: UserProfileServiceUseCase!
    var viewModel: UserProfileViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockUserProfile = MockUserProfileService()
        repository = UserProfileServiceRepository(network: mockUserProfile)
        useCase = UserProfileServiceUseCase(repo: repository)
        viewModel = UserProfileViewModel(useCase: useCase)
        
    }

    override func tearDownWithError() throws {
        
        mockUserProfile = nil
        repository = nil
        useCase = nil
        viewModel = nil
        
        try super.tearDownWithError()
    }

        
        func test_updateUser_ShouldCallUseCase_WhenCalled() async throws {
            let nameToUpdate = "NewName"
            try await viewModel.updateUser(name: nameToUpdate)
            XCTAssertTrue(mockUserProfile.didCallUpdateUser)
        }
        
        func test_delete_ShouldCallUseCase_WhenCalled() async throws {
            try await viewModel.deleteUser()
            XCTAssertTrue(mockUserProfile.didCallDeleteUser)
        }

}
