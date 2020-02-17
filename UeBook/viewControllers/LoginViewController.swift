//
//  LoginViewController.swift
//  UeBook
//
//  Created by Admin on 04/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
class LoginViewController: UIViewController , UITextFieldDelegate ,GIDSignInDelegate {
  
   
   
    @IBOutlet weak var btnGmail: UIButton!
    var iconClick = true

    @IBOutlet weak var loginView : FBLoginButton!
    @IBOutlet weak var profilePictureView : FBProfilePictureView!
    @IBOutlet weak var txtUserName: UITextField!
    

    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnPassWordHideAndShow: UIButton!
   
    @IBOutlet weak var btnFb: UIButton!
    
    var dict: NSDictionary = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationHide()
        txtUserName.delegate = self
        txtPassword.delegate = self
        txtPassword.isSecureTextEntry.toggle()
        
}

    @IBAction func btnFb(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
              // if user cancel the login
              if (result?.isCancelled)!{
                      return
              }
              if(fbloginresult.grantedPermissions.contains("email"))
              {
                self.getFBUserData()
              }
            }
          }
        }

        func getFBUserData(){
            if((AccessToken.current) != nil){
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, gender "]).start(completionHandler: { (connection, result, error) -> Void in
              if (error == nil){
                //everything works print the user data
                print(result)
                self.dict = result as! NSDictionary
                print("The result dict of fb profile::: \(self.dict)")
                let email = self.dict["email"] as! String?
                           print("The result dict[email] of fb profile::: \(String(describing: email))")
                let userID = self.dict["id"] as! String
                           print("The result dict[id] of fb profile::: \(userID)")
                let name = self.dict["first_name"] as! String
                print("The result dict[id] of fb profile::: \(name)")
                
//                let gender = self.dict["gender"] as! String
//                               print("The result dict[id] of fb profile::: \(gender)")
                
                
                
                
                
                   //            self.profileImage.image = UIImage(named: "profile")
                           let facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
                           
                           print (facebookProfileUrl)
                
                self.Register_API_Method(username: name, emailID: email!)
                
              }
                    
            })
          }
        }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          print ("hh")
      }
      
    
    @IBAction func btnGmail(_ sender: Any) {
        
//          GIDSignIn.sharedInstance()?.delegate = self
//          GIDSignIn.sharedInstance().signIn()
//
//          GIDSignIn.sharedInstance().signOut()
//          GIDSignIn.sharedInstance().disconnect()
//          GIDSignIn.sharedInstance().signIn()
        
    }
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //myActivityIndicator.stopAnimating()
    }

    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
            //print("Sign in presented")
    }
      // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
           // print("Sign in dismissed")
    }
     func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!){
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        print("Welcome: ,\(userId), \(idToken), \(fullName), \(givenName), \(familyName), \(email)")

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let chooseCVC = mainStoryboard.instantiateViewControllerWithIdentifier("ChooseCategeoriesVC") as! ChooseCategeoriesVC
//        //chooseCVC.facebookUserDetailsDict = self.facebookUserDict
//        chooseCVC.loginTypeString = "Google"
//       // let rootViewController = self.window!.rootViewController as! UINavigationController
//       // rootViewController.pushViewController(chooseCVC, animated: true)
//        self.navigationController?.pushViewController(chooseCVC, animated: true)

    }

    // Finished disconnecting |user| from the app successfully if |error| is |nil|.
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!){

    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
           print("The result dict[id] of fb profile:::")
       }

     func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if (textField == txtUserName)
        {
          
            txtUserName.textColor = UIColor.black
            

        }
        if (textField == txtPassword)
        {
          
            txtPassword.textColor = UIColor.black
            

        }
            
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        if self.txtUserName.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter User Name")
            
        }
        else if self.txtPassword.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter Password")
            
        }
        Login_API_Method()
    }
    
   
    
    
 func Login_API_Method() {
         
        let parameters: NSDictionary = [
             "user_name" : txtUserName.text!,
             "password" : txtPassword.text!,
             "device_type":"ios",
             "device_token":"0"
         ]
         
    ServiceManager.POSTServerRequest(String(kUserLogin), andParameters: parameters as! [String : String], success: {response in
             print("response-------",response!)
             //self.HideLoader()
             if response is NSDictionary {
                 let statusCode = response?["error"] as? Int
                 let resposeArr = response?["response"] as? NSDictionary

                 
                 if statusCode == 1 {
                     self.AlertVC(alertMsg:"Invalid username or password")
                    self.txtUserName.textColor = .red
                    self.txtPassword.textColor = .red
                     }
                     
             
                        
                        else if statusCode == 0 {
                                       if resposeArr == nil || resposeArr?.count == 0 {
                                           self.AlertVC(alertMsg:"Data Not Found!")
                                       }
                                       else {
                      
                      
                                        let emailUser = resposeArr?["email"] as? String
                                        let fullNameUser = resposeArr!["user_name"] as? String
                                        let UserID = resposeArr!["id"] as? String
                                        let imgUrlUser = resposeArr!["url"] as? String
                                        let publisher_type = resposeArr!["publisher_type"] as? String
                                        
                                        

                        UserDefaults.standard.set(1, forKey: "Save_User_Login")
                       // AppDelegate.methodForLogin()
                        UserDefaults.standard.set(emailUser, forKey: "Save_User_Email")
                        UserDefaults.standard.set(UserID, forKey: "Save_User_ID")
                        UserDefaults.standard.set(publisher_type, forKey: "Save_publisher_type")
                        UserDefaults.standard.set(fullNameUser, forKey: "Save_User_Name")

                                        
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                                       
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                      //  self.present(vc, animated: true, completion: nil)
                           self.AlertVC(alertMsg:"Login Successful")
                    }
                 }
                 
                 else if statusCode == 2 {
                     if resposeArr == nil || resposeArr?.count == 0 {
                         
                        
                         self.AlertVC(alertMsg:"Data Not Found!")
                         
                    }
                     
                 }
             }
         }, failure: { error in
             //self.HideLoader()
         })
     }
    
    func Register_API_Method(username: String ,emailID : String) {
         
         
         let parameters: NSDictionary = [
            "user_name": username,
             "password":  " ",
             "email":     emailID,
             "publisher_type":"Reader",
             "gender":" ",
             "country":" ",
             "about_me": " ",
             "device_type":"iOS",
             "device_token":"1234567"
             
             
          
         ]
         

         ServiceManager.POSTServerRequest(String(kCreateUser), andParameters: parameters as! [String : String], success: {response in
             print("response-------",response!)
             //self.HideLoader()
             if response is NSDictionary {
                // let statusCode = response?["error"] as? Int
                 let message = response? ["message"] as? String
               //  let resposeArr = response?["response"] as? [[String: AnyObject]]
                 
                 let messageStr = message
                 
                 if (messageStr!.elementsEqual("You are successfully registered") == true)
                 {
                      // self.AlertVC(alertMsg:"You are successfully registered")
                     
                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: kLoginViewController) as! LoginViewController
                     self.present(nextViewController, animated:true, completion:nil)
                 }
                 else if (messageStr!.elementsEqual("Oops! An error occurred while registereing") == true)
                 
                 {
                     self.AlertVC(alertMsg:"Oops! An error occurred while registereing, please retry Again")
                 }
                 else if(messageStr!.elementsEqual("Sorry, this user  already existed") == true){
                      self.AlertVC(alertMsg:"Sorry, this user  already existed")
                 }
                 
                 
                     
                 
             }
         }, failure: { error in
             //self.HideLoader()
         })
     }
     

    @IBAction func btnSignUp(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: kRegisterViewController) as! RegisterViewController
        
                                nextViewController.modalPresentationStyle = .overFullScreen
                                self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func btnPassWordHideAndShow(_ sender: Any) {
        if(iconClick == true) {
            btnPassWordHideAndShow.setImage(UIImage(named: "eye"), for: .normal)
            txtPassword.isSecureTextEntry = false
        } else {
            btnPassWordHideAndShow.setImage(UIImage(named: "eyec"), for: .normal)
            txtPassword.isSecureTextEntry = true
        }

        iconClick = !iconClick
    }
    @IBAction func btnforgotPassword(_ sender: Any) {
           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: kForgotPasswordViewController) as! ForgotPasswordViewController
           
                                   nextViewController.modalPresentationStyle = .overFullScreen
                                   self.present(nextViewController, animated:true, completion:nil)
           
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
         
         present(alert, animated: true, completion: nil)
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
