//
//  PostData.swift based on AdventData.swift
//  Průvodce Adventem
//
//  Created by Ludek Strobl on 20/04/2020.
//  Copyright © 2020 Biskupství Brněnské. All rights reserved.
//

import Foundation

extension StringProtocol {
     var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
     
 }

class PostData {

 
    
    var dataArray = [String]()
        
           
    func postLastDayDate() -> Date? {
        let date = Date()
        var dateComponents  = DateComponents()
        let formater = DateFormatter()
        formater.dateFormat = "yyyy"
        dateComponents.month = 4
        dateComponents.day = 4
        dateComponents.year = Int(formater.string(from: date))
        let calendar = Calendar.current
        let postnidoba = calendar.date(from: dateComponents)
        return postnidoba
    }
    

    func postFirstDayDate() -> Date? {

        let date = Date()
        var dateComponents  = DateComponents()
        let formater = DateFormatter()
        formater.dateFormat = "yyyy"
        dateComponents.month = 2
        dateComponents.day = 17
        dateComponents.year = Int(formater.string(from: date))
        let calendar = Calendar.current
        let postnidoba = calendar.date(from: dateComponents)
        return postnidoba
    }


    func formatujDatum(_ date:Date?) -> String {
             
             let formater = DateFormatter()
            formater.locale = Locale(identifier: Locale.preferredLanguages[0])
                          
            formater.dateFormat = ("d. MMMM yyyy")
             let datum = formater.string(from: date!)
             return datum
         }
         
    func weekdayName(_ weekdayNumber: Int) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        let weekdaySymbols = calendar.weekdaySymbols
        return weekdaySymbols[weekdayNumber-1]
    }


    func zobrazeniDatTabulky() {
        
        dataArray.removeAll()
        let date = Date() + 7*60*60
        let postFirstDate = postFirstDayDate()!
        let postLastDate = postLastDayDate()!
        
        let calendar = Calendar.current
        var odZacatkuDoTed = calendar.dateComponents([.day], from: postFirstDate, to: date ).day!
        let pocetDniPostu = calendar.dateComponents([.day], from: postFirstDate, to: postLastDate ).day!
        if date < postFirstDate {
            odZacatkuDoTed = -1
        }
        
        
        if odZacatkuDoTed >= 0 && odZacatkuDoTed-pocetDniPostu <= 15 {
            var zacatek = 0
            if odZacatkuDoTed - pocetDniPostu < 0 {
                zacatek = 0
            }
          
            else {
                zacatek = odZacatkuDoTed - pocetDniPostu
            }
            for i in zacatek...odZacatkuDoTed{
                let modifiedDate = Calendar.current.date(byAdding: .day, value: -i, to: date)
                
                
                dataArray.append("\(weekdayName(calendar.component(.weekday, from: modifiedDate!))),  \(formatujDatum(modifiedDate))".firstUppercased)
        
            }
          
        }
      
    }
    
    func poleTextu(_ texty:[String]) -> [String]{
        
        let date = Date() + 7*60*60
        let postFirstDate = postFirstDayDate()!
        let postLastDate = postLastDayDate()!
        
        let calendar = Calendar.current
        let odZacatkuDoTed = calendar.dateComponents([.day], from: postFirstDate, to: date ).day!
        let pocetDniPostu = calendar.dateComponents([.day], from: postFirstDate, to: postLastDate ).day!
        
        print(pocetDniPostu)
        print(texty.count)
        
        var poleTextu = texty
        
        poleTextu.removeLast(texty.count - pocetDniPostu - 1)
        if pocetDniPostu > odZacatkuDoTed {
           poleTextu.removeLast(pocetDniPostu - odZacatkuDoTed)
        }
        
        poleTextu.reverse()
        
        return poleTextu
    }
    
}
