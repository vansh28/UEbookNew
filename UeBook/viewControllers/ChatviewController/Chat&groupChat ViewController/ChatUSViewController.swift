//
//  ChatUSViewController.swift
//  UeBook
//
//  Created by Admin on 20/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit


class ChatUSViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
  
    
    var chatArr = [AllChatListClass]()

    var userId = String()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(ChatUSViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
  
    var filteredTableData = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
         UserChatList_API_Method()
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        //searchBar.delegate = self
            //filteredTableData = data

       self.tableView.addSubview(self.refreshControl)

        
        // Do any additional setup after loading the view.
    }
  
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    UserChatList_API_Method()
    DispatchQueue.main.async{
        self.tableView.reloadData()
    }
    }
    
     

 
     
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
         UserChatList_API_Method()

        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ChatUsTableViewCell
        
        
        cell?.userName.text = chatArr[indexPath.row].sendDetail.userName
       
        let date =  chatArr[indexPath.row].created!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "HH:mm a"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        
        cell?.lblDate.text = timeStamp
        
        if chatArr[indexPath.row].sendDetail.id == userId
        {
            cell?.userName.text = chatArr[indexPath.row].recDetail.userName
            
            cell?.UserImage.layer.cornerRadius = (cell?.UserImage.frame.height)!/2
            
            let escapedString = chatArr[indexPath.row].recDetail.url
            let fullURL = kImageUploadURL + escapedString!
            let url = URL(string:fullURL)!
            
            
            DispatchQueue.main.async {
                cell?.UserImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                
                
            }
        }
        else
        {
            
            cell?.userName.text = chatArr[indexPath.row].sendDetail.userName
            let escapedString = chatArr[indexPath.row].sendDetail.url
            let fullURL = kImageUploadURL + escapedString!
            let url = URL(string:fullURL)!
            
            cell?.UserImage.layer.cornerRadius = (cell?.UserImage.frame.height)!/2
            DispatchQueue.main.async {
                cell?.UserImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                
                
            }
        }
       
        if chatArr[indexPath.row].messCount.totalMessagecount == "0"
        {
            let mycolor = UIColor(red: (107.0/255), green: (132.0/255), blue: (145.0/255), alpha: 1.0)
            cell?.lblUnReadMessageCount.isHidden = true
            cell?.lblDate.textColor = mycolor
           // cell?.lblMessage.textColor = mycolor
        }
        else
        {
            cell?.lblUnReadMessageCount.layer.masksToBounds = true

            cell?.lblUnReadMessageCount.layer.cornerRadius = (cell?.lblUnReadMessageCount.frame.height)!/2
            cell?.lblUnReadMessageCount.isHidden = false
            cell?.lblUnReadMessageCount.text = chatArr[indexPath.row].messCount.totalMessagecount
            cell?.lblDate.textColor = UIColor.red
           // cell?.lblMessage.textColor =  UIColor.black
        }
        
        if chatArr[indexPath.row].type == "text"
        {
            cell?.lblMessage.text = chatArr[indexPath.row].message
            cell?.imageCamFileAudio.isHidden = true
            cell?.lblMessage.frame =  CGRect(x:(cell?.imageCamFileAudio.frame.origin.x)! , y: (cell?.lblMessage.frame.origin.y)!, width: (cell?.lblMessage.frame.width)!, height: (cell?.lblMessage.frame.height)!)
            

        }
        else if chatArr[indexPath.row].type == "video"
        {
             cell?.lblMessage.text = "video"
            cell?.imageCamFileAudio.image = #imageLiteral(resourceName: "video")
            cell?.imageCamFileAudio.isHidden = false

        }
        else if chatArr[indexPath.row].type == "audio"
               {
                    cell?.lblMessage.text = "Audio"
                cell?.imageCamFileAudio.image = #imageLiteral(resourceName: "audio")
                cell?.imageCamFileAudio.isHidden = false


               }
        else if chatArr[indexPath.row].type == "image"
                      {
                           cell?.lblMessage.text = "Photo"
                        cell?.imageCamFileAudio.image = #imageLiteral(resourceName: "bcamera")
                        cell?.imageCamFileAudio.isHidden = false


                      }
        else if chatArr[indexPath.row].type == "file"
                           {
                                cell?.lblMessage.text = "file"
                            cell?.imageCamFileAudio.image = #imageLiteral(resourceName: "ic_action_attachment")
                            cell?.imageCamFileAudio.isHidden = false

                           }
        return cell!
        
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ChatUsTableViewCell

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier:"ChatUserDetail") as! ChatUserDetail
                      
        nextViewController.channelId = chatArr[indexPath.row].channelId
        nextViewController.sendTO     = chatArr[indexPath.row].sendDetail.id
                 //nextViewController.modalPresentationStyle = .overFullScreen
                 self.present(nextViewController, animated:true, completion:nil)
                 print("button tapped")
        
            let mycolor = UIColor(red: (107.0/255), green: (132.0/255), blue: (145.0/255), alpha: 1.0)
               cell?.lblUnReadMessageCount.isHidden = true
               cell?.lblDate.textColor = mycolor
       
    }

    func UserChatList_API_Method()
    {
       

        let dictionary: NSDictionary = [
            "user_id" : userId
            
        ]
        
        
        ServiceManager.POSTServerRequest(String(kuser_chat_list), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
          //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["message"] as? String
                
                let userList = response?["userList"] as? NSArray
                let statusCode = response?["data"] as? Int
               
                
                
                
                if userList == nil || userList?.count == 0 {
                    
                    //self.noDataFoundLbl.isHidden = false
                    self.tableView.isHidden = true
                 }
                else {
                    self.chatArr.removeAll()
                    self.tableView.isHidden = false

                    for dataCategory in userList! {
                        
                        
                            self.chatArr.append(AllChatListClass(getChatListClass: dataCategory as! NSDictionary))
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
       
    @IBAction func btnBack(_ sender: Any) {
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
