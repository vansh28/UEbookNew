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

    

    let data = ["Vansh Raj", "kirti sharma", "Akshay", "raj, TX",
        "Deepak, PA", "vansh raj, AZ", "deepa, CA", "muskan, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    
    let messeagedata = ["hiiiiii Raj", "helooooo sharma", "byeeee", "hiiiiii, TX",
           "hii, PA", "i m here raj, AZ", "deepa, CA", "muskan, TX",
           "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
           "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
           "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    
    
    
    var filteredTableData = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredTableData = data

        Register_API_Method()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ChatUsTableViewCell
        
        
        // scamArr[indexPath.row].date_added
        cell?.userName.text = chatArr[indexPath.row].message
        cell?.lblDate.text = " 06:01:33"
        cell?.lblMessage.text = messeagedata[indexPath.row]
        
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        if let target = segue.destination as? ChatUserDetail {
            //target.selectedUser = selectedPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ChatUserDetail") as! ChatUserDetail
               self.present(next, animated: true, completion: nil)
    }
    //    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//            self.searchBar.showsCancelButton = true
//    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            searchBar.showsCancelButton = false
//            searchBar.text = ""
//            searchBar.resignFirstResponder()
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredTableData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
    
    func Register_API_Method()
    {
       

        let dictionary: NSDictionary = [
            "user_id" : "78"
            
        ]
        ServiceManager.POSTServerRequest(String(kuser_chat), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
          //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["message"] as? String
                let userList = response?["chat_list"] as? NSArray
                let statusCode = response?["error"] as? Int
               
                
                
                
                if userList == nil || userList?.count == 0 {
                    
                    //self.noDataFoundLbl.isHidden = false
                    self.tableView.isHidden = true
                 }
                else {
                    self.chatArr.removeAll()
                    self.tableView.isHidden = false

                    for dataCategory in userList! {
                        
                        self.chatArr.append(AllChatListClass(getChatListData: dataCategory as! NSDictionary))
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
