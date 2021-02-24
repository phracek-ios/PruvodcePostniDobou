//
//  LiturgickeTextyViewController.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 24.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit

class LiturgickeTextyViewController: UIViewController {
    var texty: String?
    var nazvyDnu: String?
    
    lazy var textview: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.PPDColor.mainTextColor()
        setupView()
    }
    
    func setupView() {
        self.view.addSubview(stackView)
        stackView.addSubview(textview)
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 5).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -10).isActive = true
        textview.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10).isActive = true
        textview.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10).isActive = true
        textview.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        textview.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        let html = "<h2>Liturgické texty - \(nazvyDnu!)</h2>\(texty!)"
        textview.attributedText = attributedText(html)
        textview.textColor = UIColor.label
        print(html)
    }

}
