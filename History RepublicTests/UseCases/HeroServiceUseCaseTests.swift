//
//  HeroServiceUseCaseTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 7/7/25.
//

import XCTest

@testable import History_Republic
final class HeroServiceUseCaseTests: XCTestCase {
    
    var mockHeroService: MockHeroService!
    var repository: HeroServiceRepository!
    var useCase: HeroServiceUseCase!
    

    override func setUpWithError() throws {
       try super.setUpWithError()
        
        mockHeroService = MockHeroService()
        repository = HeroServiceRepository(network: mockHeroService)
        useCase = HeroServiceUseCase(repo: repository)
        
    }

    override func tearDownWithError() throws {
        
        mockHeroService = nil
        repository = nil
        useCase = nil
        
        try super.tearDownWithError()
    }

    func testFecthHeroes_ShouldReturnHeroes_WhenIsValid() async throws {
        // Act
        let hero = try await useCase.fetchHeroes()
        // Assert
        XCTAssertNotNil(hero)
        XCTAssertEqual(hero.first?.id, UUID(uuidString: "b0b6e4d5-8f36-4e30-9f79-7d55d7d1c0a5"))
        XCTAssertEqual(hero.first?.nameHero, "Joan of Arc")
        XCTAssertEqual(hero.first?.title, "Joan of Arc")
        XCTAssertEqual(hero.first?.information, "Joan of Arc was a teen who helped turn the tide of the Hundred Years’ War.")
        XCTAssertEqual(hero.first?.image, "https://historyrepublic.com/wp-content/uploads/2025/05/Joan_of_Arc.jpg")
        XCTAssertEqual(hero.first?.url, "https://historyrepublic.com/joan-of-arc/")
    }


}
