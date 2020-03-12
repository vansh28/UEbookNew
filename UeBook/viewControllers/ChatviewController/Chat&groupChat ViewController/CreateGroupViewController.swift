//
//  CreateGroupViewController.swift
//  UeBook
//
//  Created by Admin on 06/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource ,UICollectionViewDataSource ,UICollectionViewDelegate {
    
    lazy var faButton: UIButton = {
              let button = UIButton(frame: .zero)
              button.translatesAutoresizingMaskIntoConstraints = false
              let color = UIColor(red: (95.0/255), green: (122.0/255), blue: (134.0/255), alpha: 1.0)
      
              button.backgroundColor = color
            //  button.setTitle("+", for: .normal)
              button.setImage(#imageLiteral(resourceName: "ic_action_done"), for:.normal)
              button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
      
      
              button.addTarget(self, action: #selector(fabTapped(_:)), for: .touchUpInside)
              return button
          }()
    
    var contactArr = [AllUserContactListClass]()
    var groupArr =   [AllUserContactListClass]()
    var arrGroupID = [String]()
    var  strGroupID  = String()
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    var userId = String()
    var selectedCells:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = true
     
       // tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)

         faButton.isHidden = true


        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        PhoneContactlist_API_Method(userId: userId)
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        

        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
        
        tableView.frame = CGRect(x: 0, y: collectionView.frame.origin.y + 20, width: self.view.frame.size.width, height: self.view.frame.size.height)

//        UIView.animate(withDuration: 10, animations: {
//             self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        })
              if let view = UIApplication.shared.keyWindow {
                  view.addSubview(faButton)
//                  setupButton()
              }
          }

          override func viewWillDisappear(_ animated: Bool) {
              super.viewWillDisappear(animated)
              if let view = UIApplication.shared.keyWindow, faButton.isDescendant(of: view) {
                  faButton.removeFromSuperview()
              }
          }
    func setupButton() {
                 NSLayoutConstraint.activate([
                     faButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                     faButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                     faButton.heightAnchor.constraint(equalToConstant: 60),
                     faButton.widthAnchor.constraint(equalToConstant: 60)
                     ])
                 faButton.layer.cornerRadius = 30
                 faButton.shadowOpacity = 0.5
                 faButton.layer.masksToBounds = true
         //        faButton.layer.borderColor = UIColor.lightGray.cgColor
         //        faButton.layer.borderWidth = 4
             }

       @objc func fabTapped(_ button: UIButton) {
        
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: kPopUpViewController) as! PopUpViewController
        
        popupVC.groupID = strGroupID
        popupVC.modalPresentationStyle = .popover
        popupVC.modalTransitionStyle = .flipHorizontal

        self.present(popupVC, animated: true) {
        
        
        
//        popupVC.modalPresentationStyle = .popover
//        popupVC.preferredContentSize = CGSize(width: 300, height: 300)
//                let pVC = popupVC.popoverPresentationController
//        pVC?.permittedArrowDirections = .any
//        pVC?.delegate = self as? UIPopoverPresentationControllerDelegate
//                pVC?.sourceView = button
//                pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
//        present(popupVC, animated: true, completion: nil)
            }
    }

 
       

    
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateGroupCell", for: indexPath as IndexPath) as! CreateGroupCollectionViewCell
        
        cell.lblUserName.text = groupArr[indexPath.row].name
        let escapedString = groupArr[indexPath.row].url
        let fullURL = kImageUploadURL + escapedString!
        let url = URL(string:fullURL)!
        cell.userImage.layer.cornerRadius = (cell.userImage.frame.height)/2
        DispatchQueue.main.async {
            cell.userImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
        }
        return cell
    }
    
    
    func PhoneContactlist_API_Method(userId: String)
    {
        
        
        let dictionary: NSDictionary = [
            "user_id" : "79",
            "is_all_users_list":"No"
            
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
                    self.contactArr.removeAll()
                    self.tableView.isHidden = false
                    
                    for dataCategory in userList! {
                        
                        self.contactArr.append(AllUserContactListClass(getAllUserListData: dataCategory as! NSDictionary))
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ContactTableViewCell
        
        let escapedString = contactArr[indexPath.row].url
        
        let fullURL = kImageUploadURL + escapedString!
        let url = URL(string:fullURL)!
        
        
        
        cell?.userName.text = contactArr[indexPath.row].name
        cell?.userPublisherType.text = contactArr[indexPath.row].publisher_type
        
        cell?.userImageView.layer.cornerRadius = (cell?.userImageView.frame.height)!/2
        
        
        
        DispatchQueue.main.async {
            cell?.userImageView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
            
            
        }
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var items = [String]()
        let cell = tableView.cellForRow(at: indexPath)

        if cell!.isSelected
        {
            cell!.isSelected = false
            if cell!.accessoryType == UITableViewCell.AccessoryType.none
            {
                cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
                cell!.backgroundColor = UIColor.lightGray
                collectionView.isHidden = false
                

                tableView.frame.origin.y = collectionView.frame.origin.y+collectionView.frame.height

                groupArr.append(contactArr[indexPath.row])

                arrGroupID.append(contactArr[indexPath.row].userId!)
                    strGroupID = arrGroupID.joined(separator: ",")

                
              //  arrGroupID.append(groupArr[indexPath.row].userId!)
                    


                    faButton.isHidden = false

                
                 setupButton()
                 print (strGroupID)

                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.reloadData()
                //cell?.accessoryType = UITableViewCell.AccessoryType.detailButton
            }
        }
            else
            {
                
                
              
//                    cell!.isSelected = true
//                    if cell!.accessoryType == UITableViewCell.AccessoryType.checkmark
//                    {

                        cell!.accessoryType = UITableViewCell.AccessoryType.none
                        cell!.backgroundColor = UIColor.white
                        
                        contactArr.remove(at:indexPath.row)

                //  groupArr.remove(at: contactArr[indexPath.row])
                        

                        collectionView.delegate = self
                        collectionView.dataSource = self
                        collectionView.reloadData()
                        //cell?.accessoryType = UITableViewCell.AccessoryType.detailButton
                

                }
                

        }
               

        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//               groupArr.append(contactArr[indexPath.row])
//            collectionView.delegate = self
//                          collectionView.dataSource = self
//                          collectionView.reloadData()
//    }
//
//
    
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//
//            if let index = groupArr.index(of: groupArr[indexPath.row]) {
//            groupArr.remove(at: index)
//
//
//       groupArr.remove(at:contactArr[indexPath.row])
//
//    }
    

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
 
    
}
