//
//  UIColorExtensions.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: transparency
        )
    }
    
    convenience init(p3Red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        self.init(
            displayP3Red: CGFloat(p3Red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: transparency
        )
    }
}
