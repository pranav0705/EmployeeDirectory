//
//  APIRequests.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/24/21.
//

import Foundation

protocol Requests {
  var url: URL? { get }
}

enum APIRequests: String, Requests {
  case employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
  
  var url: URL? {
    return URL(string: APIRequests.employees.rawValue)
  }
}
