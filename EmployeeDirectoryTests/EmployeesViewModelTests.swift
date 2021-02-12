//
//  EmployeesViewModelTests.swift
//  EmployeeDirectoryTests
//
//  Created by Pranav Bhandari on 1/24/21.
//

import XCTest
@testable import EmployeeDirectory

class EmployeesViewModelTests: XCTestCase {
  let employee = Employee(uuid: "1",
                          fullName: "Test Name",
                          phoneNumber: "123456789",
                          emailAddress: "test@test.com",
                          biography: "Lorem Ipsum",
                          photoUrlSmall: "testSmall.png",
                          photoUrlLarge: "testLarge.png",
                          team: "Testing",
                          employeeType: .contractor)

  func testGetNumberOfRows() {
    let viewModel = EmployeesViewModel(employees: [employee])
    XCTAssertEqual(1, viewModel.getNumberOfRows())
  }
  
  func testGetCellModel() {
    let viewModel = EmployeesViewModel(employees: [employee])
    let cellModel = viewModel.getCellModel(for: 0)
    XCTAssertEqual(cellModel.name, "Test Name")
  }
  
  func testCellIdentifier() {
    let viewModel = EmployeesViewModel(employees: [employee])
    XCTAssertEqual("employeesCell", viewModel.cellIdentifier)
  }
  
  func testFetchAllEmployees() {
    let viewModel = EmployeesViewModel(employees: [employee], serviceManager: ServiceManager(service: MockService()))
    viewModel.fetchAllEmployees { (result) in
      switch result {
      case .error( _):
        XCTFail("Error not expected")
        
      case .success(let employees):
        XCTAssertEqual(.fullTime, employees.employees.first?.employeeType)
      }
    }
  }
}
