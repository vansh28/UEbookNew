//
//  ChatUsTableViewCell.swift
//  UeBook
//
//  Created by Admin on 20/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ChatUsTableViewCell: UITableViewCell {

    @IBOutlet weak var UserImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    @IBOutlet weak var imageCamFileAudio: UIImageView!
    @IBOutlet weak var lblUnReadMessageCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
