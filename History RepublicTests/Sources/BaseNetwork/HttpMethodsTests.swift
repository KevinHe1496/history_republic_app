//
//  HttpMethodsTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 10/7/25.
//

import XCTest

@testable import History_Republic
final class HttpMethodsTests: XCTestCase {
    
    func test_HttpMethod_Post_ShouldBeCorrect() {
        XCTAssertEqual(HttpMethods.post, "POST")
    }
    
    func test_HttpMethod_Get_ShouldBeCorrect() {
        XCTAssertEqual(HttpMethods.get, "GET")
    }
    
    func test_HttpMethod_Put_ShouldBeCorrect() {
        XCTAssertEqual(HttpMethods.put, "PUT")
    }
    
    func test_HttpMethod_Delete_ShouldBeCorrect() {
        XCTAssertEqual(HttpMethods.delete, "DELETE")
    }
    
    func test_HttpHeader_Content_ShouldBeCorrect() {
        XCTAssertEqual(HttpMethods.content, "application/json")
    }
    
    func test_HttpHeader_ContentTypeID_ShouldBeCorrect() {
        XCTAssertEqual(HttpMethods.contentTypeID, "Content-Type")
    }
    
    
}
