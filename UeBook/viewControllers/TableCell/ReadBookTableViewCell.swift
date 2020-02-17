//
//  ReadBookTableViewCell.swift
//  UeBook
//
//  Created by Admin on 17/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ReadBookTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblBookName: UILabel!
    
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var starView: StarsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
