//
//  UIColor+Extension.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/21.
//  Copyright © 2020 MOMO. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b:CGFloat, alpha: CGFloat) {
        
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: r/255.0, green: g / 255.0, blue: b/255.0, alpha: alpha)
        } else {
            self.init(red: r/255.0, green: g / 255.0, blue: b/255.0, alpha: alpha)
        }
    }
    
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247, alpha: 1)
    }
}
