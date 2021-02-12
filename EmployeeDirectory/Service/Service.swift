//
//  Service.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/22/21.
//

import Foundation

class Service {
  func fetchAllEmployees(url: URL, completion: @escaping (Result<Employees>) -> Void) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil, let data = data else {
        completion(.error(APIError.network))
        return
      }
      do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let employees = try jsonDecoder.decode(Employees.self, from: data)
        UserDefaults.standard.setValue(data, forKey: "Employees")
        completion(.success(employees))
      } catch {
        print("Error while parsing all employees")
        completion(.error(APIError.parsing))
      }
    }.resume()
  }
}
