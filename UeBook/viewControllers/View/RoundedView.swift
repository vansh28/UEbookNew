//
//  RoundedView.swift
//  UeBook
//
//  Created by Admin on 23/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
@IBDesignable
 class RoundedView: UIView {
}
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
   
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
//Multiple commands produce '/Users/admin/Library/Developer/Xcode/DerivedData/UeBook-hczlpamwbkfxckfjstqqhebqtgym/Build/Products/Debug-iphoneos/UeBook.app/Frameworks/WebRTC.framework':
//1) That command depends on command in Target 'UeBook' (project 'UeBook'): script phase “[CP] Embed Pods Frameworks”
//2) That command depends on command in Target 'UeBook' (project 'UeBook'): script phase “[CP] Embed Pods Frameworks”
//Multiple commands produce '/Users/admin/Library/Developer/Xcode/DerivedData/UeBook-hczlpamwbkfxckfjstqqhebqtgym/Build/Products/Debug-iphoneos/UeBook.app/Frameworks/WebRTC.framework':
//1) That command depends on command in Target 'UeBook' (project 'UeBook'): script phase “[CP] Embed Pods Frameworks”
//2) That command depends on command in Target 'UeBook' (project 'UeBook'): script phase “[CP] Embed Pods Frameworks”
