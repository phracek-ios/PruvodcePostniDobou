//
//  PrehledTableViewController.swift
//  Průvodce Adventem
//
//  Created by Ludek Strobl on 20/04/2020.
//  Copyright © 2020 Biskupství Brněnské. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

class PrehledTableViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{.lightContent}
    
    
    var postData = PostData()
    var html = ""
    var bibleTexty = 0
    var bibleTextyZobrazeny = false
    var datum1 = ""
    var biblickeTextyButtonText = "Liturg. texty"
    var bylZobrazenText = false
    
    
    
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
        
        //tableorinfo()
        
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
               
               //tableorinfo()
           }
         
       }

}

extension PrehledTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.dataArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                   
        let rowData = postData.dataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PrehledTableViewCell.cellId, for: indexPath)
        
        cell.textLabel?.text = rowData
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let texty = PostData().poleTextu(ZobrazovaneTexty().texty)
        
        let nazvyDnu = PostData().poleTextu(ZobrazovaneTexty().nazvyDnu)
        
        let modlitba = PostData().poleTextu(ZobrazovaneTexty().modlitba)

        let pdViewController = PostniDenViewController()
        pdViewController.den = nazvyDnu[indexPath.row]
        pdViewController.texty = texty[indexPath.row]
        pdViewController.modlitba = modlitba[indexPath.row]
        navigationController?.pushViewController(pdViewController, animated: true)
    }
    

}
