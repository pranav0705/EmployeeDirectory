//
//  Result.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/23/21.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(APIError?)
}
