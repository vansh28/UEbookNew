//
//  TelephoneBookViewController.swift
//  UeBook
//
//  Created by Admin on 05/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TelephoneBookViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var userId = String()
    var arrContactListChat = [AllUserContactListClass]()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        PhoneContactlist_API_Method(userId: userId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        // Do any additional setup after loading the view.
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContactListChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ContactTableViewCell
        
        let escapedString = arrContactListChat[indexPath.row].url
        
        let fullURL = kImageUploadURL + escapedString!
        let url = URL(string:fullURL)!

        
            cell?.userName.text = arrContactListChat[indexPath.row].name
               cell?.userPublisherType.text = arrContactListChat[indexPath.row].publisher_type
                        
                        cell?.userImageView.layer.cornerRadius = (cell?.userImageView.frame.height)!/2
                        
                    
                        
                        DispatchQueue.main.async {
                            cell?.userImageView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                            
                            
                        }
               
               return cell!
        
    }
    func PhoneContactlist_API_Method(userId: String)
    {
       

        let dictionary: NSDictionary = [
            "user_id" : userId,
            "is_all_users_list":"Yes"
            
        ]
        ServiceManager.POSTServerRequest(String(kuser_list), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
          //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["message"] as? String
                let userList = response?["userList"] as? NSArray
                let statusCode = response?["error"] as? Int
               
                
                
                
                if userList == nil || userList?.count == 0 {
                    
                    //self.noDataFoundLbl.isHidden = false
                    self.tableView.isHidden = true
                 }
                else {
                    self.arrContactListChat.removeAll()
                    self.tableView.isHidden = false

                    for dataCategory in userList! {
                        
                        self.arrContactListChat.append(AllUserContactListClass(getAllUserListData: dataCategory as! NSDictionary))
                    }
                    self.tableView.reloadData()
                }
                
                
                
                
                
                if statusCode == 1 {
                  //  self.AlertVC(alertMsg:msg!)
                }
                else if statusCode == 0
                {
               }
           }
        }, failure: { error in
           // self.HideLoader()
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
