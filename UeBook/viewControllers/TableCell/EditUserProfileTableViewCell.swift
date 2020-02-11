//
//  EditUserProfileTableViewCell.swift
//  UeBook
//
//  Created by Admin on 11/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class EditUserProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var lblEntyName: UILabel!
    
    @IBOutlet weak var btnArrow: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
