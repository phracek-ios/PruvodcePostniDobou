//
//  PruvodceTabBarController.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 23.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit

class PruvodceTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Průvodce Postní Dobou"
        let prehledTableViewController = PrehledTableViewController()
        prehledTableViewController.tabBarItem = UITabBarItem(title: "Přehled", image: UIImage(named: "ic_list"), tag: 0)

        let liturgickeTextyTableViewController = LiturgickeTextyTableViewController()
        liturgickeTextyTableViewController.tabBarItem = UITabBarItem(title: "Liturgické texty", image: UIImage(named: "ic_book"), tag: 1)
        let aboutViewController = AboutViewController()
        aboutViewController.tabBarItem = UITabBarItem(title: "O průvodci", image: UIImage(named: "ic_question"), tag: 2)
        
        //let settingsTableViewController = SettingsNavigationTableViewController()
        //settingsTableViewController.tabBarItem = UITabBarItem(title: "Nastavení", tag: 2)
        
        let tabBarList = [prehledTableViewController, liturgickeTextyTableViewController, aboutViewController]
        
        viewControllers = tabBarList
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.NovenasColor.mainTextColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
