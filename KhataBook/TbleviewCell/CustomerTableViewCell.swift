//
//  CustomerTableViewCell.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 21/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    @IBOutlet weak var friendprofileimage: UIImageView!
    @IBOutlet weak var moneylbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var friendname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectionStyle = .none
    }

}
