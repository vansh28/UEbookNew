//
//  GroupChatTableViewCell.swift
//  UeBook
//
//  Created by Admin on 04/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class GroupChatTableViewCell: UITableViewCell {

    @IBOutlet weak var GroupImage: UIImageView!
    
    
    @IBOutlet weak var lblGroupName: UILabel!
    
    @IBOutlet weak var lblMesseage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
