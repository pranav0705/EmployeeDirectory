//
//  EmployeesTableViewCell.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/24/21.
//

import UIKit

class EmployeesTableViewCell: UITableViewCell {
  
  private lazy var imgView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.layer.cornerRadius = 30
    iv.layer.masksToBounds = true
    iv.layer.borderWidth = 1
    iv.layer.borderColor = UIColor(red: 222/255.0, green: 95/255.0, blue: 91/255.0, alpha: 1).cgColor
    iv.image = UIImage(named: "profilePic")
    iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
    iv.heightAnchor.constraint(equalTo: iv.widthAnchor, multiplier: 1).isActive = true
    return iv
  }()
  
  private var nameLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.numberOfLines = 0
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)
    return lbl
  }()
  
  private var teamLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.numberOfLines = 0
    lbl.font = UIFont.systemFont(ofSize: 13)
    lbl.textColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)
    return lbl
  }()
  
  private var biographyLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.numberOfLines = 0
    lbl.textColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)
    lbl.font = UIFont.systemFont(ofSize: 12)
    return lbl
  }()
  
  private var stackView: UIStackView = {
    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis = .horizontal
    sv.spacing = 16
    sv.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    sv.isLayoutMarginsRelativeArrangement = true
    sv.alignment = .top
    return sv
  }()
  
  private var labelView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    backgroundColor = UIColor(red: 37/255.0, green: 42/255.0, blue: 55/255.0, alpha: 1)
    layoutNameLabel()
    layoutTeamLabel()
    layoutBiographyLabel()
    layoutStackView()
  }
  
  func configureCell(with cellModel: CellModel) {
    nameLabel.text = cellModel.name
    teamLabel.text = cellModel.team
    biographyLabel.text = cellModel.biography
    imgView.loadImage(from: cellModel.imgUrl)
  }
  
  private func layoutNameLabel() {
    labelView.addSubview(nameLabel)
    
    nameLabel.topAnchor.constraint(equalTo: labelView.topAnchor).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor).isActive = true
    nameLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor).isActive = true
  }
  
  private func layoutTeamLabel() {
    labelView.addSubview(teamLabel)
    teamLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    teamLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor).isActive = true
    teamLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor).isActive = true
  }
  
  private func layoutBiographyLabel() {
    labelView.addSubview(biographyLabel)
    biographyLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 4).isActive = true
    biographyLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor).isActive = true
    biographyLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor).isActive = true
    biographyLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -8).isActive = true
    
  }
  
  private func layoutStackView() {
    stackView.addArrangedSubview(imgView)
    stackView.addArrangedSubview(labelView)
    contentView.addSubview(stackView)
    
    stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
