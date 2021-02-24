//
//  Colors.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 24.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct PPDColor {
        static func mainBackColor() -> UIColor {
            return UIColor(red: 0.54, green: 0.16, blue: 0.83, alpha:1.00)
        }
        
        static func mainTextColor() -> UIColor {
            return UIColor.white
        }
        
        static func textLightColor() -> UIColor {
            return UIColor.black
        }
        
        static func textNightColor() -> UIColor {
            return UIColor.white
        }
        
        static func backLightColor() -> UIColor {
            return UIColor.white
        }
        
        static func backNightColor() -> UIColor {
            return UIColor.black
        }
    }
}
