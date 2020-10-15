//
//  PaymentViewController.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 21/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    let options = ["Requset Money" , "Payment History" , "My QR Code"]
    let icons = ["Paymentrequest" , "PaymentSelect" ,"Qrcode"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payments"
        
        // Do any additional setup after loading the view.
    }

}

extension PaymentViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableViewCell", for: indexPath) as? PaymentTableViewCell else{
            return UITableViewCell()
        }
        cell.options.text = options[indexPath.row]
        cell.icon.image = UIImage(named: icons[indexPath.row])
        return cell
    }
    
    
}
