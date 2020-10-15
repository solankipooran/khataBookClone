//
//  HomeViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 02/05/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var yournumberTxtField: UITextField!
    @IBOutlet weak var businessNameTxtField: UITextField!
    @IBOutlet weak var nameTxtfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confirmBusinessName(_ sender: Any) {
        let number = yournumberTxtField.text ?? ""
        let businessname = businessNameTxtField.text ?? ""
        let name = nameTxtfield.text ?? ""
        if businessname.isEmpty || number.isEmpty || name.isEmpty{
            AlertController.showalert(title: "Something Missing", message: "Enter Business Name", action: "Okay", vc: self)
        }else{
            UserDefaults.standard.set(number, forKey: "phonenumber")
            UserDefaults.standard.set(businessname, forKey: "businessName")
            UserDefaults.standard.set(true, forKey: "flag")
            UserDefaults.standard.set(name, forKey: "username")
            let story = UIStoryboard(name: "Main", bundle: nil)
            guard  let mainvc = story.instantiateViewController(identifier: "TabBarVC") as? UITabBarController else{
                return
            }
            mainvc.modalPresentationStyle = .fullScreen
            self.present(mainvc, animated: false, completion: nil)
            
        }
    }
}
