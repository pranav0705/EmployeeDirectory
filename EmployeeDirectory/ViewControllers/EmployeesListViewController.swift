//
//  EmployeesListViewController.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/24/21.
//

import UIKit

class EmployeesListViewController: UIViewController {
  private var viewModel: EmployeesViewModel
  private var finishedLoadingInitialTableCells = false
  
  private var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.insetsContentViewsToSafeArea = true
    tv.backgroundColor = UIColor(red: 37/255.0, green: 42/255.0, blue: 55/255.0, alpha: 1)
    tv.separatorStyle = .singleLine
    tv.separatorColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 0.61)
    return tv
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)
    return refreshControl
  }()
  
  private lazy var emptyMessageLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
    return label
  }()
  
  init(viewModel: EmployeesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationController()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 54/255.0, green: 69/255.0, blue: 92/255.0, alpha: 1)
    title = "Employees"
    
    layoutTableView()
  }
  
  private func configureNavigationController() {
    let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
    navigationItem.leftBarButtonItem = backButton
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 222/255.0, green: 95/255.0, blue: 91/255.0, alpha: 1),
                                                               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    navigationController?.navigationBar.barTintColor = UIColor(red: 37/255.0, green: 42/255.0, blue: 55/255.0, alpha: 1)
    navigationController?.navigationBar.isTranslucent = false
  }
  
  private func layoutTableView() {
    tableView.register(EmployeesTableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    tableView.addSubview(refreshControl)
    
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    print("Pull to refresh Employees")
    emptyMessageLabel.text = "Refreshing"
    refetchEmployees()
  }
  
  private func refetchEmployees() {
    InternetConnectivity.shared.online { (offline) in
      if offline {
        DispatchQueue.main.async {
          self.tableView.reloadData()
          self.refreshControl.endRefreshing()
          self.displayAlert(error: APIError.offline)
        }
      } else {
        self.fetchAllEmployees()
      }
    }
  }
  
  private func fetchAllEmployees() {
    viewModel.fetchAllEmployees { (result) in
      switch result {
      case .error(let error):
        DispatchQueue.main.async {
          self.tableView.reloadData()
          self.refreshControl.endRefreshing()
          self.displayAlert(error: error)
        }
        
      case .success(let employees):
        self.viewModel = EmployeesViewModel(employees: employees.employees)
        DispatchQueue.main.async {
          self.refreshControl.endRefreshing()
          self.tableView.reloadData()
        }
      }
    }
  }
  
  private func displayAlert(error: APIError?) {
    let alertController = UIAlertController(title: "Please try again",
                                            message: error?.rawValue,
                                            preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  func updateVM(viewModel: EmployeesViewModel) {
    print("new data available")
    self.viewModel = viewModel
    tableView.reloadData()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension EmployeesListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let rows = viewModel.getNumberOfRows()
    if rows == 0 {
      setEmptyView()
    } else {
      removeEmptyView()
    }
    return rows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as? EmployeesTableViewCell else {
      return UITableViewCell()
    }
    cell.configureCell(with: viewModel.getCellModel(for: indexPath.row))
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    var lastInitialDisplayableCell = false
    
    if viewModel.getNumberOfRows() > 0 && !finishedLoadingInitialTableCells {
      if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
         let lastIndexPath = indexPathsForVisibleRows.last,
         lastIndexPath.row == indexPath.row {
        lastInitialDisplayableCell = true
      }
    }
    
    if !finishedLoadingInitialTableCells {
      if lastInitialDisplayableCell {
        finishedLoadingInitialTableCells = true
      }

      cell.transform = CGAffineTransform(translationX: 0, y: 50)
      cell.alpha = 0
      
      UIView.animate(withDuration: 0.5,
                     delay: 0.05*Double(indexPath.row),
                     options: [.curveEaseInOut],
                     animations: {
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
        cell.alpha = 1
      }, completion: nil)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Employee selected")
    let detailsVM = viewModel.getDetailsViewModel(for: indexPath.row)
    navigationController?.pushViewController(EmployeeDetailsViewController(viewModel: detailsVM), animated: true)
  }
}

//MARK: Tableview empty view
extension EmployeesListViewController {
  private func setEmptyView() {
    emptyMessageLabel.text = "Sorry! There are no employees. Pull to refresh"
    emptyMessageLabel.textColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)
    emptyMessageLabel.numberOfLines = 0
    emptyMessageLabel.textAlignment = .center
    emptyMessageLabel.font = UIFont.systemFont(ofSize: 16)
    emptyMessageLabel.sizeToFit()
    
    tableView.backgroundView = emptyMessageLabel
    tableView.separatorStyle = .none
  }
  
  func removeEmptyView() {
    tableView.backgroundView = nil
    tableView.separatorStyle = .singleLine
    tableView.separatorColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 0.61)
  }
}
