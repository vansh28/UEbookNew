//
//  PopUpViewController.swift
//  UeBook
//
//  Created by Admin on 09/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var txtGroupName: UITextField!
    
    @IBOutlet weak var lblGroupNameCount: UILabel!
    var groupID = String()
    @IBOutlet weak var btnOk: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtGroupName.delegate = self
        self.updateCharacterCount()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOK(_ sender: Any) {
        if self.txtGroupName.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter Group Name")
            
        }
        else
        {
            CreateGroup_API_Method()
            
        }
    }
    
    func updateCharacterCount() {
        let summaryCount = self.txtGroupName.text!.count
        
        self.lblGroupNameCount.text = "\((0) + summaryCount)/25"
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLength = (txtGroupName.text!.utf16.count) + (string.utf16.count) - range.length
        
        self.lblGroupNameCount.text = "\((0) +  (newLength))/25"
        
        // lblGroupNameCount.text = String(newLength)
        return textField.text!.count  <= 24
        
        
    }
    //    func textViewDidChange(_ textView: UITextView) {
    //       self.updateCharacterCount()
    //    }
    
    
    
    func AlertVC(alertMsg:String) {
        
        let alert = UIAlertController(title: alertMsg, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        present(alert, animated: true, completion: nil)
    }
    
    func CreateGroup_API_Method()
    {
        
        let userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        
        let parameters: NSDictionary = [
            "user_id": userId,
            "group_name": txtGroupName.text as Any,
            "group_user_id":groupID
        ]
        
        
        ServiceManager.POSTServerRequest(String(kaddEditGroups), andParameters: parameters as! [String : String], success: {response in
            print("response-------",response!)
            //self.HideLoader()
            if response is NSDictionary {
                let statusCode = response?["error"] as? Int
                let message = response? ["message"] as? String
                let BookDetailList = response?["data"] as? NSArray
                if statusCode == 0
                {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: kChatTapViewPagerViewController) as! ChatTapViewPagerViewController
                    
                    nextViewController.modalPresentationStyle = .overFullScreen
                    self.present(nextViewController, animated:true, completion:nil)
                   
                    
                    
                }
                else{
                    self.AlertVC(alertMsg:"Some error ocuur, Please try Again")
                }
                
                
            }
        }, failure: { error in
            //self.HideLoader()
        })
    }
    
    
    
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


