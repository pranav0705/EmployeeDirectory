//
//  MockService.swift
//  EmployeeDirectoryTests
//
//  Created by Pranav Bhandari on 1/23/21.
//

import Foundation
@testable import EmployeeDirectory

class MockService: Service {
  override func fetchAllEmployees(url: URL, completion: @escaping (Result<Employees>) -> Void) {
    let employee = Employee(uuid: "1",
                            fullName: "Test Name",
                            phoneNumber: "123456789",
                            emailAddress: "test@test.com",
                            biography: "Lorem Ipsum",
                            photoUrlSmall: "testSmall.png",
                            photoUrlLarge: "testLarge.png",
                            team: "Testing",
                            employeeType: .fullTime)
    let employees = Employees(employees: [employee])
    completion(.success(employees))
  }
}
