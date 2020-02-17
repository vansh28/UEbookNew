//
//  ForgotPasswordViewController.swift
//  UeBook
//
//  Created by Admin on 17/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SCLAlertView

class ForgotPasswordViewController: UIViewController , UITextFieldDelegate {
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var labEmail: UILabel!
    
    
    @IBOutlet weak var btnSendPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
        txtEmail.backgroundColor = UIColor.white

                      txtEmail.layer.cornerRadius = 5
                      txtEmail.layer.borderWidth = 1.0
                      txtEmail.layer.borderColor = UIColor.gray.cgColor
                      txtEmail.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        txtEmail.placeholder="Enter Email"
        labEmail.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
          if(textField == txtEmail)
          {
              txtEmail.placeholder = ""
              self.labEmail.isHidden=false
              
              let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
              txtEmail.layer.borderColor = myColor.cgColor
              
              txtEmail.layer.borderWidth = 2.0
              
          }
      }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
               
               if(textField == txtEmail)
               {
                   let myColor = UIColor.black
                   txtEmail.layer.borderColor = myColor.cgColor
                   
                   
                   txtEmail.layer.borderWidth = 1.0
                   
                   if self.txtEmail.text?.count == 0
                   {
                       txtEmail.placeholder="Enter Email"
                       self.labEmail.isHidden = true
                   }
               }
        return true
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
    @IBAction func btnSendPassword(_ sender: Any) {
       if self.txtEmail.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter Email-ID")
            
        }
        else  if isValidEmail (testStr: txtEmail.text!) == false
        {
            
            
            //txtEmail.textColor = UIColor.red
            
            AlertVC(alertMsg:"Please Enter Vaild Email-ID")
            
        }
            else
       {
        forgotPassword_Api_Method()
        }
        
    }
    
    func forgotPassword_Api_Method()
    {
       
                   
                   
                   let parameters: NSDictionary = [
                    "email": txtEmail.text as Any,
                       
                   ]
                    
                   
                   ServiceManager.POSTServerRequest(String(kforgetPassword), andParameters: parameters as! [String : String], success: {response in
                       print("response-------",response!)
                       //self.HideLoader()
                       if response is NSDictionary {
                           let statusCode = response?["error"] as? Int
                           let resposeArr = response?["response"] as? [[String: AnyObject]]
                           
                        
                        if (statusCode == 1)
                        {
                            self.AlertVC(alertMsg:" Oops! some error occurs")
                            
                        }
                        else if (statusCode == 0){
                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: kLoginViewController) as! LoginViewController
                            nextViewController.modalPresentationStyle = .overFullScreen

                            self.present(nextViewController, animated:true, completion:nil)
                        }
        
                       }
                   }, failure: { error in
                       //self.HideLoader()
                   })
               }


    @IBAction func btnBack(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
       //  alertCutsom()
    }
    func alertCutsom()
    {
       let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance).showWait("Download", subTitle: "Processing...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.setSubTitle("Progress: 10%")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.setSubTitle("Progress: 30%")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alert.setSubTitle("Progress: 50%")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        alert.setSubTitle("Progress: 70%")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            alert.setSubTitle("Progress: 90%")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                alert.close()
                            }
                        }
                    }
                }
            }
        }
        
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


