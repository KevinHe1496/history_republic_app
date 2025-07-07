//
//  HeroServiceViewModelTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 7/7/25.
//

import XCTest

@testable import History_Republic
final class HeroServiceViewModelTests: XCTestCase {
    
    var mockHeroService: MockHeroService!
    var repository: HeroServiceRepository!
    var useCase: HeroServiceUseCase!
    var viewModel: HeroesViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockHeroService = MockHeroService()
        repository = HeroServiceRepository(network: mockHeroService)
        useCase = HeroServiceUseCase(repo: repository)
        viewModel = HeroesViewModel(useCase: useCase)
        
    }

    override func tearDownWithError() throws {
       
        mockHeroService = nil
        repository = nil
        useCase = nil
        viewModel = nil
        
        try super.tearDownWithError()
    }

    func testFecthHeroes_ShouldReturnTrue_WhenIsValid() async throws {
        // Act
        _ = try await viewModel.fetchAllHeroes()
        // Assert
        XCTAssertEqual(mockHeroService.shouldReturnTrue, true)
    }


}
