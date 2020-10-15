//
//  PaymentdetailViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 24/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit
import CoreData

protocol UpdatedValue : class  {
    func updateValue(amount : Int)
}

class PaymentdetailViewController: UIViewController {
    weak var updateDelegate : UpdatedValue?
    @IBOutlet weak var paymenttableview: UITableView!
    var  amountyougave : Int = 0
    var  amountyougot : Int = 0
    var phonenumber : Int = 0
    var friendname : String = ""
    var frienddetails : [NSManagedObject] = []
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var pickerbottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTrasaction()
        self.paymenttableview.reloadData()
    }
    
    func fetchTrasaction() {
        let predicate = NSPredicate(format: "phoneFriend = '\(phonenumber)'")
        let info = CoreDataManager.fetchdata(predicate: predicate, entityname: "TransactionDetails") as? [NSManagedObject]
        let type1total = info?.filter { ($0.value(forKey: "type") as! Int) == 1 }
        let type2total = info?.filter { ($0.value(forKey: "type") as! Int) == 2 }
        let totalyougave = type1total?.reduce(0, { (amount, totalamount) -> Int in
            return amount + (totalamount.value(forKey: "amount") as! Int)
        })
        amountyougave = totalyougave as! Int
        let totalyougot = type2total?.reduce(0, { (amount, totalamount) -> Int in
            return amount + (totalamount.value(forKey: "amount") as! Int)
        })
        amountyougot = totalyougot as! Int
        frienddetails = info!.reversed()
    }
    
    @IBAction func reportbtnaction(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let reportvc = story.instantiateViewController(identifier: "ReportViewController")
        self.navigationController?.pushViewController(reportvc, animated: true)

    }
    
    @IBAction func donebtn(_ sender: Any) {
        self.paymentTableView.reloadData()
        hideunhidepicker()
    }
    
    @objc func hideunhidepicker(){
        if pickerbottom.constant == 300 {
            pickerbottom.constant = 0
        }else{
            pickerbottom.constant = 300
        }
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func yougavetbtn(_ sender: Any) {
        let type = 1
        changevc(identifier: "TransactionViewController" , typeof : type)
    }
    @IBAction func yougotbtn(_ sender: Any) {
        let type = 2
        changevc(identifier: "TransactionViewController" , typeof : type)
    }
    
    func changevc(identifier : String , typeof : Int){
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = story.instantiateViewController(identifier: identifier) as? TransactionViewController else{
            return
        }
        vc.type = typeof
        vc.phonenumber = phonenumber
        vc.name = friendname
        vc.transcationDelegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension PaymentdetailViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard  let nib = Bundle.main.loadNibNamed("Balancedetails", owner: self, options: nil)?.first as? balancedetailsview else{
            return nil
        }
        nib.selectdateoutlet.addTarget(self, action: #selector(hideunhidepicker), for: .touchUpInside)
        nib.dateofretrunmoney.text = datepicker.date.toString()
        if amountyougave > amountyougot{
            nib.resultlabel.text = "You Will Get"
            nib.amountlabel.textColor = .red
            let value1 = amountyougave - amountyougot
            nib.amountlabel.text = "\(value1)"
            updateDelegate?.updateValue(amount: value1)
        }else if amountyougot > amountyougave{
            nib.resultlabel.text = "You Will give"
            nib.amountlabel.textColor = .green
            let value2 = amountyougot - amountyougave
            nib.amountlabel.text = "\(value2)"
            updateDelegate?.updateValue(amount: value2)
        }else{
            nib.resultlabel.text = "No Dues"
            nib.amountlabel.textColor = .black
            nib.amountlabel.text = "0"
        }
        
        return nib
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 166
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frienddetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsTableViewCell", for: indexPath) as? PaymentDetailsTableViewCell else{
            return UITableViewCell()
        }
        let date = Date()
        let detail = frienddetails[indexPath.row]
        cell.timelbl.text = date.toString()
        if detail.value(forKey: "type") as? Int == 1{
            cell.yougaveamountlbl.text = "\(detail.value(forKey: "amount")!)"
            cell.yougotamountlbl.text = ""
            cell.amountmessagelbl.text = " \(detail.value(forKey: "amount")!) (You Gave)"
        }else{
            cell.yougotamountlbl.text = "\(detail.value(forKey: "amount")!)"
            cell.yougaveamountlbl.text = ""
            cell.amountmessagelbl.text = " \(detail.value(forKey: "amount")!) (You Got)"
        }
        return cell
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/LLLL"
        return formatter.string(from: self)
    }
}

extension PaymentdetailViewController: TranscationProtocol {
    func updateTranscation() {
        fetchTrasaction()
        self.paymenttableview.reloadData()
    }
}
