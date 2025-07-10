//
//  ConstantsAppTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 10/7/25.
//

import XCTest

@testable import History_Republic
final class ConstantsAppTests: XCTestCase {
    
    func test_ConsApiUrl_ShouldBeCorrect() {
        XCTAssertEqual(ConstantsApp.CONS_API_URL, "http://localhost:8080")
    }
    
    func test_ConsTokenIdKeychain_ShouldBeCorrect() {
        XCTAssertEqual(ConstantsApp.CONS_TOKEN_ID_KEYCHAIN, "com.historyrepublic.kevin.podcast2025")
    }
}
