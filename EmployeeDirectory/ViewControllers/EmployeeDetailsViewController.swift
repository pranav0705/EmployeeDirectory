//
//  EmployeeDetailsViewController.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 2/11/21.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {
  
  private let viewModel: EmployeesDetailsViewModel
  
  private lazy var imgView: UIImageView = {
    let imgView = UIImageView()
    imgView.translatesAutoresizingMaskIntoConstraints = false
    imgView.contentMode = .scaleAspectFill
    imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    return imgView
  }()
  
  private var nameText: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "Name:"
    label.textColor = .white
    return label
  }()
  
  private var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  
  private var emailText: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "Email:"
    label.textColor = .white
    return label
  }()
  
  private var emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  
  private var stackView: UIStackView = {
    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis = .vertical
//    sv.distribution = .fillProportionally
    sv.alignment = .leading
    sv.spacing = 0
    return sv
  }()
  
  init(viewModel: EmployeesDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(red: 54/255.0, green: 69/255.0, blue: 92/255.0, alpha: 1)
    layoutStackView()
  }
  
  private func layoutNameText() {
    view.addSubview(nameText)
    
    nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
    nameText.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 8).isActive = true
    
  }
  
  private func layoutStackView() {
    view.addSubview(stackView)
    
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    addSubViews()
  }
  
  private func addSubViews() {
    let nameView = EmployeeDetailsView(text: "Name:", value: viewModel.fullName)
    let emailView = EmployeeDetailsView(text: "Email:", value: viewModel.emailId)
    let teamView = EmployeeDetailsView(text: "Team:", value: viewModel.team)
    let empTypeView = EmployeeDetailsView(text: "Type:", value: viewModel.employeeType)
    let summaryView = EmployeeDetailsView(text: "Summary:", value: viewModel.summary)
    imgView.loadImage(from: viewModel.imgUrl)
    
    layoutImgView()
    stackView.addArrangedSubview(nameView)
    stackView.addArrangedSubview(emailView)
    stackView.addArrangedSubview(teamView)
    stackView.addArrangedSubview(empTypeView)
    stackView.addArrangedSubview(summaryView)
    
    
    addButton()
    stackView.addArrangedSubview(UIView())
  }
  
  private func addButton() {
    let button = UIButton()
    stackView.addArrangedSubview(button)
    
    button.setTitle(viewModel.phoneNumber, for: .normal)
    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
  }
  
  private func layoutImgView() {
    imgView.loadImage(from: viewModel.imgUrl)
    stackView.addArrangedSubview(imgView)
  }
  
  private func addSummary() {
    
  }
  
  @objc func buttonTapped(_ sender: UIButton) {
    if let text = sender.titleLabel?.text, let url = URL(string: "tel://\(text)"), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.openURL(url)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
