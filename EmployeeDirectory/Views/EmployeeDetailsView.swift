//
//  EmployeeDetailsView.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 2/11/21.
//

import UIKit

class EmployeeDetailsView: UIView {
  private var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "Name:"
    label.textColor = .white
    return label
  }()
  
  private var valueLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.textColor = .white
    label.numberOfLines = 0
    return label
  }()
  
  init(text: String, value: String) {
    super.init(frame: .zero)
    layoutTextLabel()
    layoutValueLabel()
    textLabel.text = text
    valueLabel.text = value
  }
  
  private func layoutTextLabel() {
    addSubview(textLabel)
    textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
    textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    
  }
  
  private func layoutValueLabel() {
    addSubview(valueLabel)
    valueLabel.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 4).isActive = true
    valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
    valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
