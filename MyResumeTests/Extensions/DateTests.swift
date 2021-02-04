//
//  Date.swift
//  MyResumeTests
//
//  Created by Arthur Kleiber on 03/02/2021.
//

import XCTest

class DateTests: XCTestCase {

    func testShortDateFromISO8601DateString() throws {
        var shortDateString = Date.getShortDateAsString(from: "2021-01-01")
        XCTAssertEqual(shortDateString, "Jan 2021")
        shortDateString = Date.getShortDateAsString(from: "2021-22-56")
        XCTAssertEqual(shortDateString, "Unknown")
    }
    
    
}
