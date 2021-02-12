//
//  EmployeesViewModel.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/24/21.
//

import Foundation

struct CellModel {
  let imgUrl: String
  let name: String
  let team: String
  let biography: String
}

class EmployeesViewModel {
  private var employees: [Employee]
  private let serviceManager: ServiceManager
  
  lazy var cellIdentifier: String = {
    return "employeesCell"
  }()
  
  init(employees: [Employee], serviceManager: ServiceManager = ServiceManager.shared) {
    self.employees = employees
    self.serviceManager = serviceManager
    self.employees.sort(by: { $0.fullName < $1.fullName })
  }
  
  func getNumberOfRows() -> Int {
    return employees.count
  }
  
  func getCellModel(for row: Int) -> CellModel {
    let cellModel = CellModel(imgUrl: employees[row].photoUrlSmall,
                              name: employees[row].fullName,
                              team: employees[row].team,
                              biography: employees[row].biography)
    return cellModel
  }
  
  func fetchAllEmployees(completion: @escaping (Result<Employees>) -> Void) {
    serviceManager.fetchAllEmployees(completion: { (result) in
      completion(result)
    })
  }
  
  func getDetailsViewModel(for row: Int) -> EmployeesDetailsViewModel {
    let employee = employees[row]
    return EmployeesDetailsViewModel(employee: employee)
  }
}
