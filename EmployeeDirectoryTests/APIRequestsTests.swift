//
//  APIRequestsTests.swift
//  EmployeeDirectoryTests
//
//  Created by Pranav Bhandari on 1/24/21.
//

import XCTest
@testable import EmployeeDirectory

class APIRequestsTests: XCTestCase {
  func testEmployees() {
    let urlString = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    let url = URL(string: urlString)
    XCTAssertEqual(urlString, APIRequests.employees.rawValue)
    XCTAssertEqual(url, APIRequests.employees.url)
  }
}
