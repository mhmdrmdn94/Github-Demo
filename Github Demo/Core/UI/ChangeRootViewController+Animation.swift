//
//  ChangeRootViewController+Animation.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/2/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func changeRootViewControllerWithAnimation(desinationViewController:UIViewController) {
        
        let currentViewController = UIApplication.shared.delegate?.window??.rootViewController
        let width = currentViewController?.view.frame.size.width
        let height = currentViewController?.view.frame.size.height
        
        let previousFrame = CGRect(origin: CGPoint(x: width!-1, y:0.0), size: CGSize(width: width!, height: height!))
        let nextFrame = CGRect(origin: CGPoint(x: -width!, y:0.0), size: CGSize(width: width!, height: height!))
        
        desinationViewController.view.frame = previousFrame
        UIApplication.shared.delegate?.window??.addSubview(desinationViewController.view)
        UIView.animate(withDuration: 0.5,
                       animations: { () -> Void in
                        desinationViewController.view.frame = (currentViewController?.view.frame)!
                        currentViewController?.view.frame = nextFrame
        }){ _ in
            UIApplication.shared.delegate?.window??.rootViewController = desinationViewController
        }
    }
    
}
