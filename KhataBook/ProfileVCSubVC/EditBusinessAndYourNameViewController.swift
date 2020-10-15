//
//  EditBusinessAndYourNameViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 03/05/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class EditBusinessAndYourNameViewController: UIViewController {
    var vcType: Int = 0
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if vcType == 1 {
            titlelbl.text = "Your Name"
            txtField.placeholder = "Your Name"
        }else{
            titlelbl.text = "Business Name"
            txtField.placeholder = "Business Name"
        }
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        if vcType == 1 {
            let name  = txtField.text
            UserDefaults.standard.set(name, forKey: "username")
        }else{
            let business = txtField.text
            UserDefaults.standard.set(business, forKey: "businessName")
        }
        self.navigationController?.popViewController(animated: true)
    }
    


}
