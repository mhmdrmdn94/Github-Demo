//
//  GitColor.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

enum GitColor {
    case primary
    case secondary
    case darkGray
    case darkGreen
    case darkBlue
    case custom(hexString: String, alpha: Double)
    
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
    
    var value: UIColor {
        var color = UIColor.clear
        switch self {
        case .primary:
            color = UIColor(hexString: "#2b3137")
        case .secondary:
            color = UIColor.white
        case .darkGray:
            color = UIColor(hexString: "#2b3137")   //github's dark gray
        case .darkGreen:
            color = UIColor(hexString: "#2dba4e")   //github's dark green
        case .darkBlue:
            color = UIColor(hexString: "#0e5a60")   //github's dark blue
        case .custom(let hexString, let alpha):
            color = UIColor(hexString: hexString).withAlphaComponent(CGFloat(alpha))
        }
        return color
    }
    
}
