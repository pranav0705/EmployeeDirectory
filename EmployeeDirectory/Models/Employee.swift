//
//  Employee.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/23/21.
//

import Foundation

struct Employee: Codable {
  let uuid: String
  let fullName: String
  let phoneNumber: String
  let emailAddress: String
  let biography: String
  let photoUrlSmall: String
  let photoUrlLarge: String
  let team: String
  let employeeType: EmployeeType
}

enum EmployeeType: String, Codable {
  case contractor = "CONTRACTOR"
  case fullTime = "FULL_TIME"
  case partTime = "PART_TIME"
}
