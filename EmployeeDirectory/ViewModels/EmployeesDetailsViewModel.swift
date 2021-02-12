//
//  EmployeesDetailsViewModel.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 2/11/21.
//

import Foundation

class EmployeesDetailsViewModel {
  private let employee: Employee
  
  lazy var imgUrl: String = {
    return employee.photoUrlLarge
  }()
  
  lazy var fullName: String = {
    return employee.fullName
  }()
  
  lazy var emailId: String = {
    return employee.emailAddress
  }()
  
  lazy var phoneNumber: String = {
    return employee.phoneNumber
  }()
  
  lazy var team: String = {
    return employee.team
  }()
  
  lazy var employeeType: String = {
    return employee.employeeType.rawValue
  }()
  
  lazy var summary: String = {
    return employee.biography
  }()
  
  init(employee: Employee) {
    self.employee = employee
  }
}
