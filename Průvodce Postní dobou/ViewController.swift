//
//  ViewController.swift
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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{.lightContent}
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textView: UITextView!
        
    @IBOutlet weak var seznam: UIButton!
    
    @IBOutlet weak var biblickeTexty: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    
    var postData = PostData()
    var html = ""
    var bibleTexty = 0
    var bibleTextyZobrazeny = false
    var datum1 = ""
    var biblickeTextyButtonText = "Liturg. texty"
    var bylZobrazenText = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addBackground(color: UIColor(red: 0.54, green: 0.16, blue: 0.83, alpha:1.00))
        seznam.setTitleColor(UIColor(red: 0.54, green: 0.16, blue: 0.83, alpha:1.00), for: .disabled)
        biblickeTexty.setTitleColor(UIColor(red: 0.54, green: 0.16, blue: 0.83, alpha:1.00), for: .disabled)
                
        postData.zobrazeniDatTabulky()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"

        datum1 = dateFormatter.string(from: Date() + 7*60*60)
         
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: .common)
        
        tableorinfo()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                   
        let rowData = postData.dataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bunkaTabulky", for: indexPath)
        
        cell.textLabel?.text = rowData
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        scrollToTop()
        
        transitionIn()
    
        biblickeTexty.isEnabled = true
        
        seznam.isEnabled = true
        
        let texty = PostData().poleTextu(ZobrazovaneTexty().texty)
        
        let nazvyDnu = PostData().poleTextu(ZobrazovaneTexty().nazvyDnu)
        
        let modlitba = PostData().poleTextu(ZobrazovaneTexty().modlitba)
        
        html = "<h2>\(nazvyDnu[indexPath.row])</h2>\(texty[indexPath.row])<h2>Modlitba</h2>\(modlitba[indexPath.row])"
            
        attributedText(html)
        
        bibleTexty = indexPath.row
        
        bylZobrazenText = true
    
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
               
               tableorinfo()
           }
         
       }
    
    func tableorinfo(){
        if postData.dataArray.count == 0 {
           transitionIn()
           html = ZobrazovaneTexty().oAplikaci
           attributedText(html)
           infoButton.isEnabled = false
            }
        else if postData.dataArray.count > 0 && bylZobrazenText == false{
            transitionOut()
            infoButton.isEnabled = true
            }
    }
    
    func attributedText(_ html:String){
               
        let html = #"<font size ="6em">"# + html
        
        let attrStr = try! NSAttributedString(
        data: html.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
        options:[.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
               
        textView.attributedText = attrStr
        
        textView.textColor = UIColor.label
        
    }
    
    func transitionOut(){
        
        UIView.transition(from: textView, to: tableView, duration: 0, options: .showHideTransitionViews, completion: nil)
        
        biblickeTexty.isEnabled = false
        
        seznam.isEnabled = false
        
    }
    
    func transitionIn(){
         
        UIView.transition(from: tableView, to: textView, duration: 0, options: .showHideTransitionViews, completion: nil)
            
    }
    
    func scrollToTop(){
        
        textView.setContentOffset(.zero, animated: false)
    }
    
    @IBAction func seznamClicked(_ sender: Any) {
        
        transitionOut()
        
        bibleTextyZobrazeny = false
        
        biblickeTexty.setTitle(biblickeTextyButtonText, for: .normal)
        
        infoButton.isEnabled = true
        
        bylZobrazenText = false
        
    }
    
    @IBAction func infoButtonClicked(_ sender: Any) {
        
        scrollToTop()
        
        transitionIn()
        
        html = ZobrazovaneTexty().oAplikaci
        
        attributedText(html)
        
        bibleTextyZobrazeny = false
        
        biblickeTexty.setTitle(biblickeTextyButtonText, for: .normal)
        
        biblickeTexty.isEnabled = false
        
        seznam.isEnabled = true
        
        infoButton.isEnabled = false
        
        bylZobrazenText = true
        
    }
    
    @IBAction func biblickeTextyClicked(_ sender: Any) {
        
        scrollToTop()
        
        if bibleTextyZobrazeny == false {
        
            let texty =  PostData().poleTextu(ZobrazovaneTexty().citacePisma)
            
            let nazvyDnu = PostData().poleTextu(ZobrazovaneTexty().nazvyDnu)
            
            html = "<h2>Liturgické texty - \(nazvyDnu[bibleTexty])</h2>\(texty[bibleTexty])"
    
            attributedText(html)
            
            bibleTextyZobrazeny = true
            
            biblickeTexty.setTitle("Zpět", for: .normal)
            
            
        }
        else {
            let texty = PostData().poleTextu(ZobrazovaneTexty().texty)
           
            let nazvyDnu = PostData().poleTextu(ZobrazovaneTexty().nazvyDnu)
            
            let modlitba = PostData().poleTextu(ZobrazovaneTexty().modlitba)
            
            html = "<h2>\(nazvyDnu[bibleTexty])</h2>\(texty[bibleTexty])<h2>Modlitba</h2>\(modlitba[bibleTexty])"
            
            attributedText(html)
            
            bibleTextyZobrazeny = false
            
            biblickeTexty.setTitle(biblickeTextyButtonText, for: .normal)
            
            
        }

        
    }
    

}


