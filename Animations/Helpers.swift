//
//  Helpers.swift
//  Animations
//
//  Created by Aditya Jain on 9/14/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
