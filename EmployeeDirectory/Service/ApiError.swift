//
//  ApiError.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/23/21.
//

import Foundation

enum APIError: String, Error {
  case network = "The server is under maintenance"
  case parsing = "Error fetching the data"
  case offline = "Please make sure you have an active internet connection"
}
