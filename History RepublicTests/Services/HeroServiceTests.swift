//
//  HeroServiceTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 7/7/25.
//

import XCTest

@testable import History_Republic
final class HeroServiceTests: XCTestCase {
    
    var sut: HeroService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        let stubbedSession = URLSession(configuration: config)
        
        sut = HeroService(session: stubbedSession)
        
    }
    
    override func tearDownWithError() throws {
        
        
        URLProtocolStub.stubStatusCode = 200
        URLProtocolStub.stubResponseData = nil
        URLProtocolStub.error = nil
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testFetchHeroes_ReturnsHeroes_WhenResponseIsValid() async throws {
        
        //Arrange
        let jsonData =  try MockData.loadJSONData(name: "HeroResponse")
        URLProtocolStub.stubResponseData = jsonData
        URLProtocolStub.stubStatusCode = 200
        
        // Act
        let hero = try await sut.fetchAllHeroes()
        
        // Assert
        XCTAssertNotNil(hero)
        XCTAssertEqual(hero.first?.id, UUID(uuidString: "b0b6e4d5-8f36-4e30-9f79-7d55d7d1c0a5"))
        XCTAssertEqual(hero.first?.nameHero, "Joan of Arc")
        XCTAssertEqual(hero.first?.title, "Joan of Arc")
        XCTAssertEqual(hero.first?.information, "Joan of Arc was a teen who helped turn the tide of the Hundred Years’ War.")
        XCTAssertEqual(hero.first?.image, "https://historyrepublic.com/wp-content/uploads/2025/05/Joan_of_Arc.jpg")
        XCTAssertEqual(hero.first?.url, "https://historyrepublic.com/joan-of-arc/")
        
    }
    
    
    func testFetcHereos_ThrowsError_WhenResponseIsInvalid() async throws {
        // Arrange
        URLProtocolStub.stubResponseData = Data()
        URLProtocolStub.stubStatusCode = 200
        
        // Act & Assert
        do {
            _ = try await sut.fetchAllHeroes()
            XCTFail("Expected to throw decodingError, but it did not.")
        } catch let error as HRError {
            XCTAssertEqual(error, .errorParsingData)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
}
