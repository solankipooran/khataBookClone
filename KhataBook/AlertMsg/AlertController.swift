//
//  AlertController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 27/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    static func showalert(title : String? , message : String ,action : String , vc : UIViewController){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okbutton = UIAlertAction(title: action, style: .cancel, handler: nil)
        controller.addAction(okbutton)
        vc.present(controller, animated: true, completion: nil)
    }
}
