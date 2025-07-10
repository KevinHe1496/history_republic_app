//
//  EndpointsTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 10/7/25.
//

import XCTest

@testable import History_Republic
final class EndpointsTests: XCTestCase {
    
    func test_LoginEndpoint_ShouldBeCorrect() {
        XCTAssertEqual(EndPoints.login.rawValue, "/api/auth/login")
    }
    
    func test_RegisterUsersEndpoint_ShouldBeCorrect() {
        XCTAssertEqual(EndPoints.register.rawValue, "/api/auth/register")
    }
    
    func test_GetMeEndpoint_ShouldBeCorrect() {
        XCTAssertEqual(EndPoints.fetchMe.rawValue, "/api/users/me")
    }
    
    func test_GetHeroesEndpoint_ShouldBeCorrect() {
        XCTAssertEqual(EndPoints.heroes.rawValue, "/api/heroes")
    }
    
    func test_FavoriteUserEndpoint_ShouldBeCorrect() {
        XCTAssertEqual(EndPoints.addFavorite.rawValue, "/api/favorites")
    }
}
