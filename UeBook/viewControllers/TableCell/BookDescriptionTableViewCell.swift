//
//  BookDescriptionTableViewCell.swift
//  UeBook
//
//  Created by Admin on 31/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BookDescriptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
   
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lbltimeDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    
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
