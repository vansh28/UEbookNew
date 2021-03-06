//
//  GroupChatViewController.swift
//  UeBook
//
//  Created by Admin on 04/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class GroupChatViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   var userId = String()
    var arrGroupChat = [AllGroupList]()
    lazy var refreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action:
                        #selector(ChatUSViewController.handleRefresh(_:)),
                                    for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor.red
           
           return refreshControl
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        GroupChat_API_Method(userId: userId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        self.tableView.addSubview(self.refreshControl)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        GroupChat_API_Method(userId: userId)

        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
               return arrGroupChat.count
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
             
               
               let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatCell") as? GroupChatTableViewCell
               
            cell?.lblGroupName.text = arrGroupChat[indexPath.row].name
            cell?.lblMesseage.text = arrGroupChat[indexPath.row].message
               let escapedString = arrGroupChat[indexPath.row].group_image
               let fullURL = kImageUploadURL + escapedString!
               let url = URL(string:fullURL)!
               
               
               DispatchQueue.main.async {
                   cell?.GroupImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                   
                   
               }
               
               return cell!
               
           }
    

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ChatUsTableViewCell


         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                 let nextViewController = storyBoard.instantiateViewController(withIdentifier:"ChatUserDetail") as! ChatUserDetail

        nextViewController.channelId = arrGroupChat[indexPath.row].id!
//         nextViewController.sendTO     = senderID
      //    nextViewController.ChatContactName = ChatContactName
//         nextViewController.userProfileURL = userProfileURL
         nextViewController.modalPresentationStyle = .overFullScreen
                  self.present(nextViewController, animated:true, completion:nil)
                  print("button tapped")

             let mycolor = UIColor(red: (107.0/255), green: (132.0/255), blue: (145.0/255), alpha: 1.0)
                cell?.lblUnReadMessageCount.isHidden = true
                cell?.lblDate.textColor = mycolor


//
     }
    
    
       
    func GroupChat_API_Method(userId: String) {
            
            
            let parameters: NSDictionary = [
               "user_id": userId
              ]
            

            ServiceManager.POSTServerRequest(String(kgroupList), andParameters: parameters as! [String : String], success: {response in
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                   // let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let BookDetailList = response?["data"] as? NSArray

                     print("response-------",response!)
                           
                             if BookDetailList == nil || BookDetailList?.count == 0 {
                                
                                self.tableView.isHidden = true
                               
                                let label = UILabel(frame: CGRect(x: 120, y:self.tableView.frame.size.height/2, width: 200, height: 21))
                                let color = UIColor(red: (95.0/255), green: (122.0/255), blue: (134.0/255), alpha: 1.0)

                                label.textColor = color
                              //  label.backgroundColor = .gray
                                label.font = UIFont.boldSystemFont(ofSize:20.0)
                               // label.center = CGPoint(x: 160, y: 285)
                                label.textAlignment = .left
                                label.text = "No Group Chat here"
                                self.view.addSubview(label)
                    
                             }
                              else
                             {
                                self.arrGroupChat.removeAll()
                                     self.tableView.isHidden = false
                                     
                                     for dataCategory in BookDetailList! {
                                         
                                         self.arrGroupChat.append(AllGroupList(getAllGroupList: dataCategory as! NSDictionary))
                                         
                                         
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
