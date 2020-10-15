//
//  ViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 21/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var frienddata : [NSManagedObject] = []
    var amountFromVC : Int = 0
    var searchIsOn = false
    var searchItem : [NSManagedObject] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var businessNamelbl: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var youwillgive: UILabel!
    @IBOutlet weak var youwillgetlbl: UILabel!
    @IBAction func reportbtn(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let reportvc = story.instantiateViewController(identifier: "ReportViewController")
        self.navigationController?.pushViewController(reportvc, animated: true)
        
    }
    @IBAction func Addfriendprofile(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let addfriendprofilevc = story.instantiateViewController(identifier: "AddnewfriendprofileViewController")
        self.navigationController?.pushViewController(addfriendprofilevc, animated: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)        
        businessNamelbl.text = UserDefaults.standard.string(forKey: "businessName")
        fetchinfo()
        let friendList = CoreDataManager.fetchdata(entityname: "Friends" )
        frienddata = friendList as! [NSManagedObject]
        homeTableView.reloadData()
        
    }
    
    func fetchinfo(){
        let info = CoreDataManager.fetchdata(entityname: "TransactionDetails") as? [NSManagedObject]
        let type1total = info?.filter { ($0.value(forKey: "type") as! Int) == 1 }
        let type2total = info?.filter { ($0.value(forKey: "type") as! Int) == 2 }
        let totalyougave = type1total?.reduce(0, { (amount, totalamount) -> Int in
            return amount + (totalamount.value(forKey: "amount") as! Int)
        })
        let totalyougot = type2total?.reduce(0, { (amount, totalamount) -> Int in
            return amount + (totalamount.value(forKey: "amount") as! Int)
        })
        let netBalance = (totalyougot! - totalyougave!)
        if netBalance > 0 {
            youwillgetlbl.text = "\(abs(netBalance))"
            youwillgive.text = "0"
        }else{
            youwillgetlbl.text = "0"
            youwillgive.text = "\(abs(netBalance))"
            
        }
    }
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let nib = Bundle.main.loadNibNamed("PaymentsectionView", owner: self, options: nil)?.first as? PaymentHeaderVIew else {
            return nil
        }
        nib.filter.addTarget(self, action: #selector(filteroption), for: .touchUpInside)
        nib.numberofCustomer.text = "\(frienddata.count) Customer"
        return nib
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchIsOn{
            return searchItem.count
        }else{
            return frienddata.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell", for: indexPath) as? CustomerTableViewCell else{
            return UITableViewCell()
        }
        let user = searchIsOn ? searchItem[indexPath.row] : frienddata[indexPath.row]
        cell.friendname.text = user.value(forKey: "nameFriend") as? String
        cell.timelbl.text = user.value(forKey: "date") as? String
        cell.moneylbl.text = "\(amountFromVC)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = frienddata[indexPath.row]
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let paymentvc = story.instantiateViewController(identifier: "PaymentdetailViewController") as? PaymentdetailViewController else {
            return
        }
        paymentvc.phonenumber = user.value(forKey: "phoneFriend") as! Int
        paymentvc.friendname = user.value(forKey: "nameFriend") as! String
        paymentvc.updateDelegate = self
        self.navigationController?.pushViewController(paymentvc, animated: true)
    }
    
    @objc  func filteroption(){
        let controller = UIAlertController(title: nil, message: "Sort By", preferredStyle: .actionSheet)
        let latestaction = UIAlertAction(title: "Latest", style: .default, handler: nil)
        let oldestaction = UIAlertAction(title: "Oldest", style: .default, handler: nil)
        let byamountaction = UIAlertAction(title: "Most Amount", style: .default, handler: nil)
        let bynameaction = UIAlertAction(title: "By Name(A-Z)", style: .default, handler: nil)
        let cancelaction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        controller.addAction(latestaction)
        controller.addAction(oldestaction)
        controller.addAction(byamountaction)
        controller.addAction(bynameaction)
        controller.addAction(cancelaction)
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    
    
}

extension ViewController : UpdatedValue{
    func updateValue(amount: Int) {
        amountFromVC = amount
    }
}

extension ViewController :  UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchIsOn = false
            homeTableView.reloadData()
        }else{
            searchIsOn = true
        }
        let searchName = frienddata.filter{($0.value(forKey: "nameFriend") as! String).lowercased().hasPrefix(searchText.lowercased())}
        searchItem = searchName
        homeTableView.reloadData()
    }
}

