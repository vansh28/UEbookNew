//
//  pendingRequestTableViewCell.swift
//  UeBook
//
//  Created by Admin on 03/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class pendingRequestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserType: UILabel!
    
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
