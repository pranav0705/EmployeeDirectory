//
//  ServiceManagerTests.swift
//  EmployeeDirectoryTests
//
//  Created by Pranav Bhandari on 1/24/21.
//

import XCTest
@testable import EmployeeDirectory

class ServiceManagerTests: XCTestCase {
  func testFetchAllEmployees() {
    let serviceManager = ServiceManager(service: MockService())
    serviceManager.fetchAllEmployees { (result) in
      switch result {
      case .error( _):
        break
        
      case .success(let employees):
        XCTAssertEqual(1, employees.employees.count)
        XCTAssertEqual("1", employees.employees.first?.uuid)
        XCTAssertEqual(.fullTime, employees.employees.first?.employeeType)
      }
    }
  }
}
