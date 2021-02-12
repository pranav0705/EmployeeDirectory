//
//  ServiceManager.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/22/21.
//

import Foundation

protocol EmployeeDirectoryProtocol {
  func fetchAllEmployees(request: Requests?, completion: @escaping (Result<Employees>) -> Void)
}

class ServiceManager: EmployeeDirectoryProtocol {
  static let shared = ServiceManager()
  let service: Service
  
  init(service: Service = Service()) {
    self.service = service
  }
  
  func fetchAllEmployees(request: Requests? = APIRequests.employees,
                         completion: @escaping (Result<Employees>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      if let data = UserDefaults.standard.object(forKey: "Employees") as? Data {
        do {
          let jsonDecoder = JSONDecoder()
          jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
          let employees = try jsonDecoder.decode(Employees.self, from: data)
          completion(.success(employees))
        } catch {
          UserDefaults.standard.removeObject(forKey: "Employees")
          print("Error while parsing all employees")
          completion(.error(APIError.parsing))
        }
      }
    }
    guard let url = request?.url else {
      return
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
      self.service.fetchAllEmployees(url: url) { (result) in
        completion(result)
      }
    }
  }
}
