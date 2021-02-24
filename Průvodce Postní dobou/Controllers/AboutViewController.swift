//
//  AboutViewController.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 23.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    lazy var aboutLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = UIColor.PPDColor.textLightColor()
        l.backgroundColor = UIColor.PPDColor.mainTextColor()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = UIColor.PPDColor.mainTextColor()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.backgroundColor = UIColor.PPDColor.mainTextColor()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "O aplikaci"
        self.view.backgroundColor = UIColor.PPDColor.mainTextColor()
        setupView()
    }
    
    func setupView() {
        self.view.addSubview(stackView)
        stackView.addSubview(scrollView)
        scrollView.addSubview(aboutLabel)
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 5).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        aboutLabel.attributedText = attributedText(ZobrazovaneTexty().oAplikaci) 
        aboutLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        aboutLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        aboutLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive
            = true
        aboutLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}

