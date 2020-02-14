//
//  UserInfoViewController.swift
//  UeBook
//
//  Created by Admin on 12/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit


class UserInfoViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserType: UILabel!
    
    @IBOutlet weak var lblPostCount: UILabel!
    
    
    @IBOutlet weak var btnEditProfile: UIButton!
    
       var userBookDetailArr = [AllUserBooklist]()
       var userId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        UserInfo_API_Method()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150

        // Do any additional setup after loading the view.
    }
    @IBAction func btnEditProfile(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: kUserInfoUpdateViewController) as! UserInfoUpdateViewController
                       //nextViewController.valueNote = "1"

        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBookDetailArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell") as? UserInfoTableViewCell
        
                cell?.lblBookName.text = userBookDetailArr[indexPath.row].book_title
        cell?.lblUserName.text = userBookDetailArr[indexPath.row].author_name
                

                let myDouble = userBookDetailArr[indexPath.row].rating
                let double = Double(myDouble!)
                cell?.starView.rating = double!
              
        //        cell?.layer.masksToBounds = true
        //        cell?.imgView.layer.cornerRadius = ((cell?.imgView.frame.size.width)!)/2

                let escapedString = userBookDetailArr[indexPath.row].thubm_image
                       let fullURL = "http://" + escapedString!
                       let url = URL(string:fullURL)!


                       DispatchQueue.main.async {


                           self.getData(from: url) { data, response, error in
                               guard let data = data, error == nil else {
                                   cell?.imgView?.image = #imageLiteral(resourceName: "noimage")
                                   return }
                               print(response?.suggestedFilename ?? url.lastPathComponent)
                               print("Download Finished")
                               DispatchQueue.main.async() {

                                   cell?.imgView?.image = UIImage(data: data)

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
