//
//  AddnewfriendprofileViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 22/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class AddnewfriendprofileViewController: UIViewController {
    var countrycode = [[String:String]]()
    @IBOutlet weak var selcectcountrycode: UIButton!
    @IBOutlet weak var nameusertxtfield: UITextField!
    @IBOutlet weak var phonenumbertxtfield: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var bottomPickerConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path = Bundle.main.path(forResource: "CountryCode", ofType: "plist") else{
            return
        }
        guard let dict = NSDictionary(contentsOfFile: path) else{
            return
        }
        countrycode = dict.object(forKey: "CountryCode") as! [[String : String]]

        title = "Customers Details"
        settxtfieldimage(textfield : nameusertxtfield  , imagename : "user")
        
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
        phonenumbertxtfield.becomeFirstResponder()
        
    }
    @IBAction func nextbutton(_ sender: Any) {
        let customername = nameusertxtfield.text ?? ""
        let phonenumber = phonenumbertxtfield.text ?? ""
        let date = Date()
        if customername.isEmpty || phonenumber.isEmpty{
            AlertController.showalert(title: "Incomplete Entry", message: "Please Fill", action: "Ok", vc: self)
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
        let dateOfCreate = date.converttostring()
        let customerDetailsDict : [String : Any] = ["nameFriend" : customername , "phoneFriend": Int(phonenumber) , "date" : dateOfCreate ]
        CoreDataManager.savedata(dict: customerDetailsDict, entityName: "Friends")
        
    }
  
    func settxtfieldimage(textfield : UITextField , imagename : String){
        nameusertxtfield.leftViewMode = UITextField.ViewMode.always
        let leftimageview  = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        leftimageview.image = UIImage(named: imagename)
        let leftview = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        leftview.addSubview(leftimageview)
        textfield.leftView = leftview
        
    }
    
    func showHidePicker() {
        if bottomPickerConstant.constant == 0 {
            bottomPickerConstant.constant = -260
        } else {
            bottomPickerConstant.constant = 0
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func selectCountry(_ sender: Any) {
        phonenumbertxtfield.resignFirstResponder()
        showHidePicker()
    }
    
    @IBAction func Done(_ sender: Any) {
        showHidePicker()
    }
    
}

extension AddnewfriendprofileViewController : UIPickerViewDataSource , UIPickerViewDelegate {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countrycode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x:0, y:0, width: pickerView.bounds.width - 30, height: 60))

        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        myImageView.image = UIImage(named: countrycode[row]["Flag"]! )
       
        let myLabel = UILabel(frame: CGRect(x:60, y:0, width: pickerView.bounds.width - 90, height:60 ))
        myLabel.text = countrycode[row]["Code"]
        myLabel.textAlignment = .center

        myView.addSubview(myLabel)
        myView.addSubview(myImageView)

        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selcectcountrycode.setTitle(countrycode[row]["Code"], for: .normal)
        selcectcountrycode.setImage(UIImage(named: countrycode[row]["Flag"] ?? ""), for: .normal)
    }
    
    
}

extension Date {
    func converttostring() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/LLLL"
        return formatter.string(from: self)
    }
}
