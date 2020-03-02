//
//  UserInfoViewController.swift
//  UeBook
//
//  Created by Admin on 12/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SCLAlertView
import Foundation

class UserInfoViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var userImage: UIImageView!
    
     var arrGetFollowStatus = [AllFollowStatus]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserType: UILabel!
    
    @IBOutlet weak var lblPostCount: UILabel!
    var userIdbyAuthor = String()
    
    @IBOutlet weak var btnEditProfile: UIButton!
    var valueBtn = String()
       var userBookDetailArr = [AllUserBooklist]()
       var userId = String()
    var flag = 0
    
    @IBOutlet weak var btnSendingRequest: UIButton!
    
    @IBOutlet weak var btnEmail: UIButton!
    var Userimageurl :URL!
    var Username = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.frame.width/2
        
        let Imageurl = UserDefaults.standard.string(forKey: "Save_Img_url")!
        let fullURL = kImageUploadURL + Imageurl
        let url = URL(string:fullURL)!
        self.Userimageurl = url
        self.userImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
         lblUserName.text = Username
       userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
       if valueBtn == "1"
            {
                if userId == userIdbyAuthor
                {
                    userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
                                   btnEditProfile.isHidden = false
                                   btnEmail.isHidden = true
                                   btnSendingRequest.isHidden = true
                }
                
                else{
                    btnEmail.isHidden = false
                    btnSendingRequest.isHidden = false
                    btnEditProfile.isHidden = true
                    userId = userIdbyAuthor
                    print(userId)
                }
                 
            }
           else  if valueBtn == "2"
            {
                userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
                btnEditProfile.isHidden = false
                btnEmail.isHidden = true
                btnSendingRequest.isHidden = true
            }
        
        
            UserInfo_API_Method()
            GetFollowStatus_API_Method()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        
        
     
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSendingRequest(_ sender: Any) {
        
        if flag == 0
        {
             btnSendingRequest.isUserInteractionEnabled = true
            SendFrndReq_API_Method()
        }
        else if flag == 1        {
             btnSendingRequest.isUserInteractionEnabled = true
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: kChatUserDetail) as! ChatUserDetail
                           //nextViewController.valueNote = "1"

            
            //nextViewController.modalPresentationStyle = .overFullScreen
            self.present(nextViewController, animated:true, completion:nil)
        }
        else if flag == 2        {
            btnSendingRequest.isUserInteractionEnabled = false
        }
       
    }
    
    @IBAction func btnEmail(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
                   kTitleFont: UIFont(name: "HelveticaNeue", size: 15)!,
                   kTextFont: UIFont(name: "HelveticaNeue", size: 15)!,
                   kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 15)!,
                   showCloseButton: false,
                   dynamicAnimatorActive: true
               )
//
               // Initialize SCLAlertView using custom Appearance
               let alert = SCLAlertView(appearance: appearance)
               let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)

               // Creat the subview
               let subview = UIView(frame: CGRect(x: 0,y: 0,width: 216,height: 250))
               let x = (subview.frame.width - 180)
               
               // Add textfield 1
               let textfield1 = UITextField(frame: CGRect(x: 0,y: 10,width: 216,height:50))
               textfield1.layer.borderColor = myColor.cgColor
               textfield1.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)

               textfield1.layer.borderWidth = 1.5
               textfield1.layer.cornerRadius = 5
               textfield1.placeholder = "Subject"
               textfield1.textAlignment = NSTextAlignment.left
               subview.addSubview(textfield1)
               
               // Add textfield 2
               let textView = UITextView(frame: CGRect(x: 0,y: textfield1.frame.maxY + 10,width: 216,height:150))
               //textView.isSecureTextEntry = true
               textView.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)

               textView.layer.borderColor = myColor.cgColor
               textView.layer.borderWidth = 1.5
               textView.layer.cornerRadius = 5
               textView.text = "Write your Message"
                
               textView.textAlignment = NSTextAlignment.left
               subview.addSubview(textView)
               
               // Add the subview to the alert's UI property
               alert.customSubview = subview
               _ = alert.addButton("SEND", backgroundColor:myColor, textColor: .white)  {
                   print("Logged in")
               }
               
                //Add Button with visible timeout and custom Colors
               let showTimeout = SCLButton.ShowTimeoutConfiguration(prefix: "(", suffix: " s)")
        _ = alert.addButton("CANCEL", backgroundColor:myColor, textColor: .white, showTimeout: showTimeout) {
                   print("Timeout Button tapped")
               }

               let timeoutValue: TimeInterval = 10.0
               let timeoutAction: SCLAlertView.SCLTimeoutConfiguration.ActionType = {
                   print("Timeout occurred")
               }
               
               _ = alert.showInfo("Email", subTitle: "")
           
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: kUserInfoUpdateViewController) as! UserInfoUpdateViewController
                       //nextViewController.valueNote = "1"
        nextViewController.Userimageurl = Userimageurl
        nextViewController.Username = lblUserName.text!
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier:kSWRevealViewController ) as! SWRevealViewController
        nextViewController.indexValue = "0"
        nextViewController.modalPresentationStyle = .overFullScreen
       
        self.present(nextViewController, animated:true, completion:nil)
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBookDetailArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell") as? UserInfoTableViewCell
        
                cell?.lblBookName.text = userBookDetailArr[indexPath.row].book_title
        cell?.lblUserName.text = userBookDetailArr[indexPath.row].author_name
                

                let myDouble = userBookDetailArr[indexPath.row].rating
        if myDouble == nil{
            cell?.starView.rating = 0
        }
        else
        {
                let double = Double(myDouble!)
                cell?.starView.rating = double!
        }

                let escapedString2 = userBookDetailArr[indexPath.row].thubm_image
        
                       let imageFullUrl = "http://" + escapedString2!
        print(imageFullUrl)
        
        let imageURl = URL(string:"http://" + escapedString2!)!
                        
                      print(imageURl)
                       DispatchQueue.main.async {


                           self.getData(from: imageURl) { data, response, error in
                               guard let data = data, error == nil else {
                                   cell?.imgView?.image = #imageLiteral(resourceName: "noimage")
                                   return }
                               print(response?.suggestedFilename ?? imageURl.lastPathComponent)
                               print("Download Finished")
                               DispatchQueue.main.async() {
                                cell?.imgView?.af_setImage(withURL:imageURl , placeholderImage:#imageLiteral(resourceName: "noimage") )

                                   //cell?.imgView?.image = UIImage(data: data)

                               }
                           }
                }
        
        return cell!
        
    }
    
 
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
                        }
    
    func UserInfo_API_Method() {
        
        
        let parameters: NSDictionary = [
           "user_id": userId
          ]
        

        ServiceManager.POSTServerRequest(String(kgetUserDetails), andParameters: parameters as! [String : String], success: {response in
            print("response-------",response!)
            //self.HideLoader()
            if response is NSDictionary {
               // let statusCode = response?["error"] as? Int
                let message = response? ["message"] as? String
                
                let UserDetail = response?["data"] as? NSDictionary

                let BookDetailList = response?["booklist"] as? NSArray
                
                
                
                if UserDetail == nil || UserDetail?.count == 0 {
                    }
                else {
                    let objUserDetails = AllUserDetails(getUserDetails : UserDetail!)
                    
                    
                    if objUserDetails.user_name == nil
                    {
                        self.lblUserName.text = ""
                    }
                    else{
                        self.lblUserName.text =  objUserDetails.user_name
                    }
//
                    if objUserDetails.publisher_type == nil
                    {
                        self.lblUserType.text = " "

                    }
                    else{
                        self.lblUserType.text =  objUserDetails.publisher_type
                    }

                    if objUserDetails.url == ""
                     {
                         
                     }
                    
                     else
                     {
                        self.userImage.layer.cornerRadius = self.userImage.frame.size.height/2
                         
                                 let escapedString = objUserDetails.url
                                 let fullURL = kImageUploadURL + escapedString!
                                 let url = URL(string:fullURL)!
                                 
                                 
                                 DispatchQueue.main.async {
                                     
                                     
                                     self.getData(from: url) { data, response, error in
                                         guard let data = data, error == nil else {
                                            // self.userImage.image = #imageLiteral(resourceName: "user_default")
                                             return }
                                         print(response?.suggestedFilename ?? url.lastPathComponent)
                                         print("Download Finished")
                                         DispatchQueue.main.async() {
                                            
                // userImage.sd_setImage(with: URL(string: url), placeholderImage:#imageLiteral(resourceName: "Default_Img"))
                                             
                                             //self.userImage.image = UIImage(data: data)
                                         }
                                     }
                                 }
                    }
                }
                 print("response-------",response!)
                       
                         if BookDetailList == nil || BookDetailList?.count == 0 {
                            
                            
                
                         }
                          else
                         {
                                 self.userBookDetailArr.removeAll()
                                 self.tableView.isHidden = false
                                 
                                 for dataCategory in BookDetailList! {
                                     
                                     self.userBookDetailArr.append(AllUserBooklist(getAllUserBooklist: dataCategory as! NSDictionary))
                                     print(self.userBookDetailArr.count)
                                    let arrCount = self.userBookDetailArr.count
                                    
                                    self.lblPostCount.text = "Post - " +  String(arrCount)
                                     
                                 }
                                 self.tableView.reloadData()
                             }
                
                        
                
                
                
            }
        }, failure: { error in
            //self.HideLoader()
        })
    }
    
    
     func SendFrndReq_API_Method() {
            
            userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
            let parameters: NSDictionary = [
               "user_id": userId,
                "frnd_id":userIdbyAuthor
              ]
            

            ServiceManager.POSTServerRequest(String(ksendFrndReq), andParameters: parameters as! [String : String], success: {response in
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                   // let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    
                    
                    self.GetFollowStatus_API_Method()
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
        }
    
    
    func GetFollowStatus_API_Method() {
             
             userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
             let parameters: NSDictionary = [
                "user_id": userId,
                "friend_id":userIdbyAuthor
               ]
             

             ServiceManager.POSTServerRequest(String(kgetFollowStatus), andParameters: parameters as! [String : String], success: {response in
                 print("response-------",response!)
                 //self.HideLoader()
                 if response is NSDictionary {
                    // let statusCode = response?["error"] as? Int
                     let message = response? ["message"] as? String
                     let GetFolowStatusdata =    response? ["data"] as? NSArray
                     
                     if GetFolowStatusdata == nil || GetFolowStatusdata?.count == 0 {
                                 
                                 
                     
                              }
                               else
                              {
                                      self.userBookDetailArr.removeAll()
                                      
                                      for dataCategory in GetFolowStatusdata! {
                                          
                                          self.arrGetFollowStatus.append(AllFollowStatus(getFollowStatus: dataCategory as! NSDictionary))
                                          print(self.userBookDetailArr.count)
                                        
                                        let stautsType = self.arrGetFollowStatus[0].status
                                        
                                        if stautsType == "1"
                                        {
                                            self.btnSendingRequest.setTitle("MESSAGE", for: .normal)
                                            
                                            self.flag = 1
                                            self.btnSendingRequest.isUserInteractionEnabled = true

                                        }
                                        else if  stautsType == "0"
                                        {
                                            self.btnSendingRequest.isUserInteractionEnabled = false

                                            self.btnSendingRequest.setTitle("PENDING", for: .normal)
                                            self.flag = 2
                                            
                                        }
                                        else if  stautsType == "2"
                                        {
                                            self.btnSendingRequest.setTitle("REJECT", for: .normal)
                                            self.btnSendingRequest.isUserInteractionEnabled = true

                                            
                                        }
                                        else
                                        {
                                            self.flag = 0
                                            self.btnSendingRequest.isUserInteractionEnabled = true

                                            self.btnSendingRequest.setTitle("FOLLOW", for: .normal)
                                        }
                                        
                                }
                    }
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
