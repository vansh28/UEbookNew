//
//  BookAssignmentTableViewCell.swift
//  UeBook
//
//  Created by Admin on 25/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BookAssignmentTableViewCell: UITableViewCell ,UITextViewDelegate {
    
    
    
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblAnswer: UILabel!
    var textChanged: ((String) -> Void)?

    
    @IBOutlet weak var lblAnswerTextView: UILabel!
    
    @IBOutlet weak var textViewAnswer: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        textViewAnswer.delegate = self
        textViewAnswer.textColor = UIColor.lightGray
        lblAnswerTextView.isHidden = true
        textViewAnswer.layer.cornerRadius = 5
        
        let myColor = UIColor.gray
        textViewAnswer.layer.borderColor = myColor.cgColor
        
        textViewAnswer.layer.borderWidth = 1.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
 
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray || textView.text == ""{
                       textView.text = nil
                       textView.textColor = UIColor.black
                       
                       let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
                       textViewAnswer.layer.borderColor = myColor.cgColor
                       
                       textViewAnswer.layer.borderWidth = 2.0
                       self.lblAnswerTextView.textColor = myColor
                       self.lblAnswerTextView.isHidden=false
                       
                   }
        print("bye")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
       let myColor = UIColor.gray
       textViewAnswer.layer.borderColor = myColor.cgColor
       
       textViewAnswer.layer.borderWidth = 1.0
                 if(textView == textViewAnswer)
                 {
                     if self.textViewAnswer.text?.count == 0
                     {
                         
                         textViewAnswer.text = "Anwser"
                         textViewAnswer.textColor = UIColor.lightGray
                         lblAnswerTextView.isHidden = true
                         }
                     
                 }
        print("hello")
        
    }

}
