//
//  PendingRequestViewController.swift
//  UeBook
//
//  Created by Admin on 03/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class PendingRequestViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    var userId = String()
    var arrPendingRequest = [AllFollowStatus]()
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        PendingRequset_API_Method()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 126
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPendingRequest.count
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as? pendingRequestTableViewCell
        cell?.lblUserName.text = arrPendingRequest[indexPath.row].user_name
        cell?.lblUserType.text = arrPendingRequest[indexPath.row].publisher_type
        let escapedString = arrPendingRequest[indexPath.row].url
        let fullURL = kImageUploadURL + escapedString!
        let url = URL(string:fullURL)!
        
        
        DispatchQueue.main.async {
            cell?.userImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
            
            
        }
        cell?.btnConfirm.tag = indexPath.row
                     
                     cell?.btnConfirm.addTarget(self, action: #selector(ConfimRequestTapped(_:)), for: .touchUpInside)
        
        cell?.btnDelete.tag = indexPath.row
               
               cell?.btnDelete.addTarget(self, action: #selector(DeleteTapped(_:)), for: .touchUpInside)
               
        
        return cell!
     }
    
    
    @objc func ConfimRequestTapped(_ sender: UIButton){
         
        let friendId = arrPendingRequest[sender.tag].id
        let status = "1"
        requestConfim(Status: status, friendId: friendId!)
            
        }
     @objc func DeleteTapped(_ sender: UIButton){
        
               let friendId = arrPendingRequest[sender.tag].id
               let status = "2"
               requestConfim(Status: status, friendId: friendId!)
        
    }
    
 
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    func requestConfim(Status:String,friendId : String)
    {
        let parameters: NSDictionary = [
               "friend_id": friendId,
               "status":Status
            
              ]
        

            ServiceManager.POSTServerRequest(String(kacceptedRequest), andParameters: parameters as! [String : String], success: {response in
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response?["message"] as? String

                     print("response-------",response!)
                           
                    if statusCode == 0
                    {
                        self.AlertVC(alertMsg:message!)
                        self.PendingRequset_API_Method()
                    }
                    else
                    {
                        
                    }
                            
                    
                        
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
        }
  
    
    func PendingRequset_API_Method() {
            
            
            let parameters: NSDictionary = [
               "user_id": userId
              ]
            

            ServiceManager.POSTServerRequest(String(kgetAllRequestbyUser), andParameters: parameters as! [String : String], success: {response in
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
                                label.text = "No Pending Request"
                                self.view.addSubview(label)
                    
                             }
                              else
                             {
                                self.arrPendingRequest.removeAll()
                                     self.tableView.isHidden = false
                                     
                                     for dataCategory in BookDetailList! {
                                         
                                         self.arrPendingRequest.append(AllFollowStatus(getFollowStatus: dataCategory as! NSDictionary))
                                         
                                         
                                     }
                                     self.tableView.reloadData()
                                 }
                    
                            
                    
                        
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
