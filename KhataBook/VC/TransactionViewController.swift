//
//  TransactionViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 30/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

protocol TranscationProtocol: class {
    func updateTranscation()
}

class TransactionViewController: UIViewController {
    
    weak var transcationDelegate: TranscationProtocol?
    
    var type : Int = 0
    var phonenumber :  Int =  0
    var name : String = ""
    @IBOutlet weak var transactionBtn: UIButton!
    @IBOutlet weak var amounttxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if type == 1 {
            transactionBtn.backgroundColor = .red
            transactionBtn.titleLabel?.font = UIFont(name: "You Gave", size: 30)
            
        }else{
            transactionBtn.backgroundColor = .green
            transactionBtn.titleLabel?.font = UIFont(name: "You Got", size: 30)
        }
    }
    
    @IBAction func transactionbtn(_ sender: Any) {
        let amount = amounttxtField.text ?? ""
        if amount.isEmpty {
            AlertController.showalert(title: "Missing", message: "Please Enter Amount", action: "ok", vc: self)
        }else{
            let amountdictionary : [String:Any] = ["amount" : Double(amount) ,"nameFriend" : name ,"phoneFriend" : Int(phonenumber) , "type" : type]
            CoreDataManager.savedata(dict: amountdictionary, entityName: "TransactionDetails")
            transcationDelegate?.updateTranscation()
        }
        self.dismiss(animated: true, completion: nil)
    }
}
