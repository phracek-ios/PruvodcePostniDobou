//
//  PrehledTableViewCell.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 23.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit

class PrehledTableViewCell: UITableViewCell {
    
    static let cellId = "PrehledTableViewCell"
    
    var name: String?
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    func configureCell(name: String) {
        contentView.addSubview(stackView)
        stackView.addBackground(color: UIColor(red: 0.54, green: 0.16, blue: 0.83, alpha:1.00))
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5).isActive = true
        stackView.addSubview(label)
        label.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10).isActive = true
        label.text = name
        label.textColor = UIColor.label
    }
}
