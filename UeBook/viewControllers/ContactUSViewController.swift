//
//  ContactUSViewController.swift
//  UeBook
//
//  Created by Admin on 14/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ContactUSViewController: UIViewController , UITextViewDelegate , UITextFieldDelegate{
    
    
    
    @IBOutlet weak var lblEmail: UILabel!
    
    
    @IBOutlet weak var lblContactNumber: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    var userId  = String()
    var userName = String()
    var emailID = String()
    @IBOutlet weak var textViewMessageWrite: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        userName = UserDefaults.standard.string(forKey: "Save_User_Name")!
        emailID =  UserDefaults.standard.string(forKey: "Save_User_Email")!
        print (emailID)
        
        
                   txtEmail.delegate = self
                  txtEmail.placeholder="Enter Email"
                  lblEmail.isHidden = true
                  txtEmail.layer.cornerRadius = 5
                  txtEmail.layer.borderWidth = 1.0
                  txtEmail.layer.borderColor = UIColor.gray.cgColor
                  txtEmail.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
            txtContactNumber.delegate = self
            txtContactNumber.placeholder="Enter your Contact Number"
            lblContactNumber.isHidden = true
            txtContactNumber.layer.cornerRadius = 5
            txtContactNumber.layer.borderWidth = 1.0
            txtContactNumber.layer.borderColor = UIColor.gray.cgColor
            txtContactNumber.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            
            

            textViewMessageWrite.text = "Write your message"
            lblMessage.isHidden = true
            textViewMessageWrite.layer.cornerRadius = 5
            textViewMessageWrite.layer.borderWidth = 1.0
            textViewMessageWrite.layer.borderColor = UIColor.gray.cgColor
            textViewMessageWrite.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        textViewMessageWrite.text = ""
        textViewMessageWrite.delegate = self
                          textViewMessageWrite.text = "Write your message"
                          textViewMessageWrite.textColor = UIColor.lightGray
                          lblMessage.isHidden = true
            
            

        // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
                   //activeDataArray = []
                   
                   
                      let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
                   
                   if(textField == txtEmail)
                   {
                       txtEmail.placeholder = ""
                       self.lblEmail.isHidden=false
                       
                    
                       txtEmail.layer.borderColor = myColor.cgColor
                       
                       txtEmail.layer.borderWidth = 2.0
                       
                   }
                   else if(textField == txtContactNumber)
                   {
                       txtContactNumber.placeholder = ""
                       self.lblContactNumber.isHidden=false
                       
                      
                       txtContactNumber.layer.borderColor = myColor.cgColor
                       
                       txtContactNumber.layer.borderWidth = 2.0
                       
                   }
                  
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    let myColor = UIColor.black

    if(textField == txtEmail)
    {
        let myColor = UIColor.black
        txtEmail.layer.borderColor = myColor.cgColor
        
        txtEmail.layer.borderWidth = 1.0
        
        if self.txtEmail.text?.count == 0
        {
            txtEmail.placeholder="Enter Email"
            self.lblEmail.isHidden = true
        }
    }
       
          
        
        
        
        
      else  if(textField == txtContactNumber)
                   {
                       txtContactNumber.layer.borderColor = myColor.cgColor
                       
                       txtContactNumber.layer.borderWidth = 1.0
                       
                       if self.txtContactNumber.text?.count == 0
                       {
                           txtContactNumber.placeholder="Enter your Contact"
                           self.lblContactNumber.isHidden = true
                       }
                   }
         return true
    }
    
  func textViewDidBeginEditing(_ textView: UITextView) {
          if textView.textColor == UIColor.lightGray {
              textView.text = nil
              textView.textColor = UIColor.black
              
              let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
              textViewMessageWrite.layer.borderColor = myColor.cgColor
              
              textViewMessageWrite.layer.borderWidth = 1.0
              
              self.lblMessage.isHidden=false
             
          }
      }
      
      func textViewDidEndEditing(_ textView: UITextView) {
         
          
          let myColor = UIColor.black
          textViewMessageWrite.layer.borderColor = myColor.cgColor
          
          textViewMessageWrite.layer.borderWidth = 1.0
          
          if(textView == textViewMessageWrite)
          {
              if self.textViewMessageWrite.text?.count == 0
              {
                  
                  textViewMessageWrite.text = "Write your message"
                  textViewMessageWrite.textColor = UIColor.lightGray
                  lblMessage.isHidden = true
                  
                  
                  
                  
                  //self.lblUpdateUser.isHidden = true
                  //  self.lblEmailUpdate.isHidden = true
                  
                  // self.lblUpdateCountry.isHidden = true
                  
              }
              
          }
          
          
      
          
          
      }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
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
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        // AJAlertController.initialization().showAlertWithOkButton(aStrMessage: alertMsg) { (index, title) in
        
    }
    @IBAction func btnSend(_ sender: Any) {
        if self.txtEmail.text?.count == 0
               {
                   AlertVC(alertMsg:"Please Enter Email-ID")
                   
               }
               else  if isValidEmail (testStr: txtEmail.text!) == false
               {
                   
                   
                   //txtEmail.textColor = UIColor.red
                   
                   AlertVC(alertMsg:"Please Enter Vaild Email-ID")
                   
               }
                   
                   
               else if self.txtContactNumber.text?.count == 0
               {
                   AlertVC(alertMsg:"Please Enter Contact Number")
                   
               }
            
               
                else if self.textViewMessageWrite.text?.count == 0
                {
                   AlertVC(alertMsg:"Please Write your message")
                   
               }
           
          else
                {
//                   txtEmail.text = ""
//                   txtEmail.placeholder="Email"
//                   lblEmail.isHidden = true
//                   
//                   txtContactNumber.text = ""
//
//                   txtContactNumber.placeholder="Contact Number"
//                   lblContactNumber.isHidden = true
//                   
//                   
//                   textViewMessageWrite.text = ""
//
//                   textViewMessageWrite.text = "Write your message"
//                   textViewMessageWrite.textColor = UIColor.lightGray
//                   lblMessage.isHidden = true
                   

           Contact_Us()
               }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    func Contact_Us() {
           
           
           let parameters: NSDictionary = [
               "user_id": userId,
               "name":  userName,
               "email": txtEmail.text!,
               "phone": txtContactNumber.text!,
               "contatMessage":textViewMessageWrite.text!
           ]
            
           
           ServiceManager.POSTServerRequest(String(kcontact_us), andParameters: parameters as! [String : String], success: {response in
               print("response-------",response!)
               //self.HideLoader()
               if response is NSDictionary {
                   let statusCode = response?["error"] as? Int
                   let resposeArr = response?["response"] as? [[String: AnyObject]]
                   
                
                self.txtEmail.text = ""
                self.txtEmail.placeholder="Email"
                self.lblEmail.isHidden = true
                
                self.txtContactNumber.text = ""
                
                self.txtContactNumber.placeholder="Contact Number"
                self.lblContactNumber.isHidden = true
                
                
                self.textViewMessageWrite.text = ""
                
                self.textViewMessageWrite.text = "Write your message"
                self.textViewMessageWrite.textColor = UIColor.lightGray
                self.lblMessage.isHidden = true
//                   if statusCode == 1 {
//                       self.AlertVC(alertMsg:"Error, Please retry")
//                       // self.AlertVC(alertMsg:"Invalid username or password")
//                   }
//                   else if statusCode == 0 {
//                       if resposeArr == nil || resposeArr?.count == 0 {
//                           self.AlertVC(alertMsg:"Successfully send your mail")
//                           //self.AlertVC(alertMsg:"Data Not Found!")
//                       }
                       
                       
                 //  }
               }
           }, failure: { error in
               //self.HideLoader()
           })
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
