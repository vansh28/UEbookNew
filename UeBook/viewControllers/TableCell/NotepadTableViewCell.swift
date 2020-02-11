//
//  NotepadTableViewCell.swift
//  UeBook
//
//  Created by Admin on 10/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NotepadTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDateTime: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnShare(_ sender: Any) {
    }
}
