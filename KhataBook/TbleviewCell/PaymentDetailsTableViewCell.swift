//
//  PaymentDetailsTableViewCell.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 24/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class PaymentDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var amountmessagelbl: UILabel!
    @IBOutlet weak var yougaveamountlbl: UILabel!
    
    @IBOutlet weak var yougotamountlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
