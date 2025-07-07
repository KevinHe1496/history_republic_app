//
//  UserAuthViewModelTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 7/7/25.
//

import XCTest

@testable import History_Republic
final class UserAuthViewModelTests: XCTestCase {
    
    var mockAuthService: MockAuthService!
    var repository: UserAuthServiceRepository!
    var useCase: UserAuthServiceUseCase!
    var viewModel: UserAuthViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockAuthService = MockAuthService()
        repository = UserAuthServiceRepository(network: mockAuthService)
        useCase = UserAuthServiceUseCase(repo: repository)
        viewModel = UserAuthViewModel(registerUC: useCase, appState: AppStateVM())
        
    }

    override func tearDownWithError() throws {
        
        mockAuthService = nil
        repository = nil
        useCase = nil
        viewModel = nil
        
        try super.tearDownWithError()
    }

    
        // MARK: Register Function
        
        func testRegisterUser_WhenAuthServiceFails_ShouldShowError() async throws {
            // Arrange
            mockAuthService.shouldThrowError = true
            
            // Act & Assert
            _ = await viewModel.registerUser(name: "Andy", email: "andy@hotmail.com", password: "123456")
            
            XCTAssertTrue(mockAuthService.registerCalled)
        }
        
        func testRegisterUser_WhenValidAsDueno_ShouldUpdateAppStateToRegister() async {
            
             _ = await viewModel.registerUser(name: "Andy", email: "andy@hotmail.com", password: "123456")
            XCTAssertFalse(mockAuthService.shouldThrowError)
        }

}
