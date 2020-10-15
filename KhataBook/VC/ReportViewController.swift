//
//  ReportViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 22/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit
import CoreData

class ReportViewController: UIViewController , UIActionSheetDelegate {
    var overallTransactionDetails : [NSManagedObject] = []
    @IBOutlet weak var yougavelbl: UILabel!
    @IBOutlet weak var yougotlbl: UILabel!
    @IBOutlet weak var numberofenterieslbl: UILabel!
    @IBOutlet weak var enddatelbl: UILabel!
    @IBOutlet weak var startdate: UILabel!
 
    @IBOutlet weak var youwillgetlbl: UILabel!
    
    @IBOutlet weak var youWillGivelbl: UILabel!
    @IBOutlet weak var netbalancelbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        if let info = CoreDataManager.fetchdata(entityname: "TransactionDetails") as? [NSManagedObject] {
            numberofenterieslbl.text = "\(info.count) Enteries "
            overallTransactionDetails = info.reversed()
            let type1total = info.filter { ($0.value(forKey: "type") as! Int) == 1 }
            let type2total = info.filter { ($0.value(forKey: "type") as! Int) == 2 }
            let yougaveamount = type1total.reduce(0) { (amount, object) -> Int in
                return amount + (object.value(forKey: "amount") as! Int)
            }
            yougavelbl.text = "\(yougaveamount)"
            youwillgetlbl.text = "You have sent \(yougaveamount)"
            let yougotamount = type2total.reduce(0) { (amount, object) -> Int in
                return amount + (object.value(forKey: "amount") as! Int)
            }
            yougotlbl.text = "\(yougotamount)"
            youWillGivelbl.text = "You will receive \(yougotamount)"
            let netBalance = yougotamount - yougaveamount
            if netBalance > 0{
                netbalancelbl.textColor = .green
                netbalancelbl.text = "\(abs(yougaveamount - yougotamount))"
            }else{
                netbalancelbl.textColor = .red
                netbalancelbl.text = "\(abs(yougotamount - yougaveamount))"
            }
        }
        
        
        
        
    }
    
    @IBAction func selectdatebtn(_ sender: Any) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let allaction = UIAlertAction(title: "All", style: .default, handler: nil)
        let lastweekaction = UIAlertAction(title: "Last Week", style: .default, handler: nil)
        let lastmonthaction = UIAlertAction(title: "Last Month", style: .default, handler: nil)
        let dateaction = UIAlertAction(title: "Date", style: .default, handler: nil)
        let daterangeaction = UIAlertAction(title: "Date Range", style: .default, handler: nil)
        let cancelaction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        controller.addAction(allaction)
        controller.addAction(lastweekaction)
        controller.addAction(lastmonthaction)
        controller.addAction(dateaction)
        controller.addAction(daterangeaction)
        controller.addAction(cancelaction) 
        self.present(controller, animated: true, completion: nil)
        
    }
    
}

extension ReportViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return overallTransactionDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReportTableViewCell") as? ReportTableViewCell else{
            return UITableViewCell()
        }
        let data = overallTransactionDetails[indexPath.row]
        
        cell.friendnmaelbl.text = data.value(forKey: "nameFriend") as? String
        if data.value(forKey: "type") as? Int == 1{
            cell.yougaveamntlbl.text = "\(data.value(forKey: "amount")!)"
            cell.yougotamntlbl.text = ""
        }else{
            cell.yougotamntlbl.text = "\(data.value(forKey: "amount")!)"
            cell.yougaveamntlbl.text = ""
        }
        
        
        
        return cell
    }
}

