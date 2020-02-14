//
//  CategiesTableViewCell.swift
//  UeBook
//
//  Created by Admin on 13/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CategiesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var viewCat: UIView!
    @IBOutlet weak var lblCategiresName: UILabel!
    
    @IBOutlet weak var lblNumberOfBooks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
