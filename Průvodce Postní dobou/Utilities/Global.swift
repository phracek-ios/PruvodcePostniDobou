//
//  Global.swift
//  PruvodcePostniDobou
//
//  Created by Petr Hracek on 24.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class Global {
    
    static func appFont() -> String{
        return "Helvetica"
    }
}

func get_cgfloat(size: String) -> CGFloat {
    guard let n = NumberFormatter().number(from: size) else { return 0 }
    let f = CGFloat(truncating: n)
    return f
}
