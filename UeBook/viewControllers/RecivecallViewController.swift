//
//  RecivecallViewController.swift
//  UeBook
//
//  Created by Admin on 17/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RecivecallViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.borderWidth = 1
        userImage.layer.cornerRadius = userImage.frame.height/2.0
        userImage.layer.borderColor = UIColor.gray.cgColor
        self.userImage.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCancel(_ sender: Any) {
      
    }
    
    @IBAction func btmRecive(_ sender: Any) {
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
