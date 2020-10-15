//
//  MyCustomView.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 02/05/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

@IBDesignable
class MyCustomView: UIView {
    
    var r = 0
    @IBInspectable
    var radius : Int {
        set {
            self.layer.cornerRadius = CGFloat(newValue)
            self.clipsToBounds = true
        } get {
            return r
        }
    }



}
