//
//  UIView+PinToEdges.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

//MARK:- to pin items to their containers using code,, ex: custom views
extension UIView {
    func activateLayoutAttributes(_ attributes: [NSLayoutAttribute],
                                  for item: UIView,
                                  constants: [CGFloat] = [0, 0, 0, 0]) {
        var i = -1
        NSLayoutConstraint.activate(attributes.map {
            i += 1
            return NSLayoutConstraint(item: item, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: constants[i])
        })
    }
    
    func pinItemToEdges(item: UIView,
                        constants: [CGFloat] = [0, 0, 0 ,0]) {
        item.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutAttribute] = [.top, .trailing, .bottom, .leading]
        activateLayoutAttributes(attributes, for: item, constants: constants)
    }
    
    func pinItemToMargins(item: UIView,
                          constants: [CGFloat] = [0, 0, 0 ,0]) {
        item.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutAttribute] = [.firstBaseline, .trailing, .bottom, .leading]
        activateLayoutAttributes(attributes, for: item, constants: constants)
    }
    
    func centerItemHorizontally(item: UIView) {
        NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    }
    
    func centerItemVertically(item: UIView) {
        NSLayoutConstraint(item: item, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
}


extension UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    @discardableResult
    func loadFromNib(named: String,
                     owner: UIView? = nil,
                     options: [AnyHashable : Any]? = nil) -> UIView? {
        let nibOwner    = owner ?? self
        let bundle      = Bundle(for: type(of: self))
        let nib         = UINib(nibName: named, bundle: bundle)
        return nib.instantiate(withOwner: nibOwner, options: options).first as? UIView
    }
}
