//
//  ProfileTableViewCell.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 26/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var optionname: UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var extralabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


