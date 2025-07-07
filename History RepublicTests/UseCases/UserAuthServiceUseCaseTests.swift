//
//  UserAuthServiceUseCaseTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 7/7/25.
//

import XCTest

@testable import History_Republic
final class UserAuthServiceUseCaseTests: XCTestCase {
    
    var mockAuthService: MockAuthService!
    var repository: UserAuthServiceRepository!
    var useCase: UserAuthServiceUseCase!

    override func setUpWithError() throws {
       try super.setUpWithError()
        
        mockAuthService = MockAuthService()
        repository = UserAuthServiceRepository(network: mockAuthService)
        useCase = UserAuthServiceUseCase(repo: repository)
        
    }

    override func tearDownWithError() throws {
        
        mockAuthService = nil
        repository = nil
        useCase = nil
        
        try super.tearDownWithError()
    }

    func testLogin_Successful_ReturnsTrueAndStoresToken() async throws {
            
            //Arrange
            mockAuthService.shouldReturnToken = "mockedLoginToken"
            mockAuthService.shouldThrowError = false
            
            // Act
            let result = try await useCase.loginApp(user: "andy@hotmail.com", password: "123456")
            // Assert
            XCTAssertTrue(result, "Expected login to return true for valid credentials.")
            XCTAssertTrue(mockAuthService.loginCalled, "Expected login to be called in repository.")
        }

    
    func testLogin_ThrowsError_WhenServiceFails() async throws {
           // Arrange
           mockAuthService.shouldThrowError = true
           // Act & Assert
           do {
               _ = try await useCase.loginApp(user: "test@mail.com", password: "1234")
               XCTFail("Expected login to throw an error, but it did not.")
           } catch let error as NSError {
               XCTAssertEqual(error, NSError(domain: "MockAuthService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Login failed"]))
           }
       }
       
       
       // MARK: Register
       
       func testRegister_Succesful_ReturnsTrueAndStoresToken() async throws {
           
           //Arrange
           mockAuthService.shouldReturnToken = "mockedRegisterToken"
           mockAuthService.shouldThrowError = false
           
           //Act
           let result = try await useCase.registerUser(
               name: "Andy",
               email: "andy@hotmail.com",
               password: "123456"
           )
           
           // Assert
           XCTAssertTrue(result)
           XCTAssertTrue(mockAuthService.registerCalled)
           XCTAssertEqual(useCase.tokenJWT, "mockedRegisterToken")
          
       }
       
       func testRegister_ThrowsError_WhenServiceFails() async throws {
           // Arrage
           mockAuthService.shouldThrowError = true
           
           // Act & Assert
           do {
                _ = try await useCase.registerUser(
                   name: "Andy",
                   email: "fail@mail.com",
                   password: "1234"
               )
               XCTFail("Expected login to throw an error, but it did not.")
           } catch let error as NSError {
               XCTAssertEqual(error, NSError(domain: "MockAuthService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Register failed"]))
           }
       }
}
