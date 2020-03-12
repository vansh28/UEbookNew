   //
//  FirstPageViewController.swift
//  UeBook
//
//  Created by Admin on 04/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

   class FirstPageViewController: UIViewController {
    
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationHide()

        
            scrollView.contentSize = CGSize(width:view.frame.width, height: 750)
   
        
  
    }
    

    @IBAction func signUpNow(_ sender: Any) {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: kRegisterViewController) as! RegisterViewController
        
                                nextViewController.modalPresentationStyle = .overFullScreen
                                self.present(nextViewController, animated:true, completion:nil)
                              
                                   
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
