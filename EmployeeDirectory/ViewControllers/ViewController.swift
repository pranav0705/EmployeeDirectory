//
//  ViewController.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/23/21.
//

import UIKit

class ViewController: UIViewController {
  
  private var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Employee Directory"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 30)
    label.textColor = UIColor(red: 222/255.0, green: 95/255.0, blue: 91/255.0, alpha: 1)
    return label
  }()
  
  private lazy var loadingIndicator: UIActivityIndicatorView = {
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    loadingIndicator.color = .white
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    return loadingIndicator
  }()
  
  private let serviceManager: ServiceManager
  private var isLoaded = false
  private var employeesListVC: EmployeesListViewController?
  
  init(serviceManager: ServiceManager = ServiceManager.shared) {
    self.serviceManager = serviceManager
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 54/255.0, green: 69/255.0, blue: 92/255.0, alpha: 1)
    
    layoutTitleLabel()
    layoutLoadingIndicator()
    checkInternetConnection()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func checkInternetConnection() {
    loadingIndicator.startAnimating()
    InternetConnectivity.shared.online { (offline) in
      if offline {
        DispatchQueue.main.async {
          self.loadingIndicator.stopAnimating()
          self.displayAlert(error: APIError.offline)
        }
      } else {
        self.fetchAllEmployees()
      }
    }
  }
  
  private func fetchAllEmployees() {
    serviceManager.fetchAllEmployees(completion: { (result) in
      switch result {
      case .error(let error):
        DispatchQueue.main.async {
          self.loadingIndicator.stopAnimating()
          self.displayAlert(error: error)
        }
        
      case .success(let employees):
        print(employees)
        DispatchQueue.main.async {
          if self.isLoaded {
            self.updateVM(employees: employees.employees)
          } else {
            self.navigateToEmployeeListVC(employees: employees.employees)
          }
        }
      }
    })
  }
  
  private func navigateToEmployeeListVC(employees: [Employee]) {
    isLoaded = true
    let vm = EmployeesViewModel(employees: employees)
    let employeesListVC = EmployeesListViewController(viewModel: vm)
    self.loadingIndicator.stopAnimating()
    self.navigationController?.pushViewController(employeesListVC, animated: true)
  }
  
  private func updateVM(employees: [Employee]) {
    let vm = EmployeesViewModel(employees: employees)
    employeesListVC?.updateVM(viewModel: vm)
  }
  
  private func layoutTitleLabel() {
    view.addSubview(titleLabel)
    
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func layoutLoadingIndicator() {
    view.addSubview(loadingIndicator)
    
    loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
  }
  
  private func displayAlert(error: APIError?) {
    let alertController = UIAlertController(title: "Please try again",
                                            message: error?.rawValue,
                                            preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

