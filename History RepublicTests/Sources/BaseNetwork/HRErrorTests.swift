//
//  HRErrorTests.swift
//  History RepublicTests
//
//  Created by Andy Heredia on 10/7/25.
//

import XCTest

@testable import History_Republic
final class HRErrorTests: XCTestCase {

    func testDescriptions() {
           XCTAssertEqual(HRError.requestWasNil.description, "Error creating request")
           XCTAssertEqual(HRError.errorFromServer(reason: NSError(domain: "Test", code: 404)).description, "Received error from server 404")
           XCTAssertEqual(HRError.errorFromApi(statusCode: 500).description, "Received error from api status code 500")
           XCTAssertEqual(HRError.dataNoReveiced.description, "Data no received from server")
           XCTAssertEqual(HRError.errorParsingData.description, "There was un error parsing data")
           XCTAssertEqual(HRError.sessionTokenMissing.description, "Seesion token is missing")
           XCTAssertEqual(HRError.badUrl.description, "Bad url")
           XCTAssertEqual(HRError.authenticationFailed.description, "Authentication Failed")
       }

}
