//
//  HttpResponseCodesTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 10/7/25.
//

import XCTest

@testable import History_Republic
final class HttpResponseCodesTests: XCTestCase {
    
    func test_HttpResponseCodes_Success_ShouldBe200() {
        XCTAssertEqual(HttpResponseCodes.SUCESS, 200)
    }
    
    func test_HttpResponseCodes_Success_ShouldBe201() {
        XCTAssertEqual(HttpResponseCodes.SUCCESS_CREATE, 201)
    }
    
    func test_HttpResponseCodes_NotAuthorized_ShouldBe401() {
        XCTAssertEqual(HttpResponseCodes.NOT_AUTHORIZED, 401)
    }
    
    func test_HttpResponseCodes_Error_ShouldBe502() {
        XCTAssertEqual(HttpResponseCodes.ERROR, 502)
    }
    
}
