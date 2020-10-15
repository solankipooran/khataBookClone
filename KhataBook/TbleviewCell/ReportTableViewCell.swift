//
//  ReportTableViewCell.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 22/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var yougotamntlbl: UILabel!
    @IBOutlet weak var yougaveamntlbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var friendnmaelbl: UILabel!
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
