//
//  Utils.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 23.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit

func attributedText(_ html:String) -> NSAttributedString {
           
    let html = #"<font size ="6em">"# + html
    
    let attrStr = try! NSAttributedString(
    data: html.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
    options:[.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
           
    return attrStr
    
}

