//
//  LiturgickeTextyTableViewController.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 24.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit


class LiturgickeTextyTableViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{.lightContent}
    
    var postData = PostData()
    var html = ""
    var datum1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postData.zobrazeniDatTabulky()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PrehledTableViewCell.self, forCellReuseIdentifier: PrehledTableViewCell.cellId)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        datum1 = dateFormatter.string(from: Date() + 7*60*60)
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: .common)
    }

    @objc func fire() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        let datum2 = dateFormatter.string(from: Date() + 7*60*60)
           
        if datum2 != datum1 {
            postData.zobrazeniDatTabulky()
            let pocetbunek = tableView.numberOfRows(inSection: 0)
            let pocetpoli = postData.dataArray.count
                           
            if pocetbunek < pocetpoli {
                let indexPath = (0 ..< pocetpoli - pocetbunek).map { IndexPath(row: $0, section: 0) }
                tableView.beginUpdates()
                tableView.insertRows(at: indexPath, with: .automatic)
                tableView.endUpdates()
            }
            else if pocetbunek > pocetpoli {
                let indexPath = (0 ..< pocetbunek - pocetpoli).map { IndexPath(row: $0, section: 0) }
                tableView.beginUpdates()
                tableView.deleteRows(at: indexPath, with: .automatic)
                tableView.endUpdates()
            }
               datum1 = datum2
           }
         
       }

}

extension LiturgickeTextyTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                   
        let rowData = postData.dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PrehledTableViewCell.cellId, for: indexPath)
        print(rowData)
        cell.textLabel?.text = "Lit. texty - \(rowData)"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bibleTexty = indexPath.row
        let texty =  PostData().poleTextu(ZobrazovaneTexty().citacePisma)
        let nazvyDnu = PostData().poleTextu(ZobrazovaneTexty().nazvyDnu)
        let ltViewController = LiturgickeTextyViewController()
        ltViewController.texty = texty[bibleTexty]
        ltViewController.nazvyDnu = nazvyDnu[bibleTexty]
        navigationController?.pushViewController(ltViewController, animated: true)
    }
    

}
