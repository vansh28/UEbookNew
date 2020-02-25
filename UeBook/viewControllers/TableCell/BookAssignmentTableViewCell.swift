//
//  BookAssignmentTableViewCell.swift
//  UeBook
//
//  Created by Admin on 25/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BookAssignmentTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblAnswer: UILabel!
    
    
    @IBOutlet weak var lblAnswerTextView: UILabel!
    
    @IBOutlet weak var textViewAnswer: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
