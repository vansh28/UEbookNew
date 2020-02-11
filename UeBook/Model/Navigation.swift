//
//  Navigation.swift
//  UeBook
//
//  Created by Admin on 11/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
 {

    func navigationHideBackTitle()
 {
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.backItem?.title = ""
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.tintColor = .white

    }
    
    func navigationHide()
    {
       navigationController?.navigationBar.isHidden = true
        
    }
    func navigationShow()
    {
        navigationController?.navigationBar.isHidden = false
        
    }
}
