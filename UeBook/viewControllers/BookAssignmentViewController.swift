//
//  BookAssignmentViewController.swift
//  UeBook
//
//  Created by Admin on 25/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BookAssignmentViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
   
    

    var bookId  = String()
    var questionList = String()
    var id = String()
    var assignmaintArr = [AllAssignmentList]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 210
        // Do any additional setup after loading the view.
    }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return assignmaintArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
          
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell") as? BookAssignmentTableViewCell
            
            cell?.lblQuestion.text = assignmaintArr[indexPath.row].question
            

         
            
            return cell!
            
        }
    @IBAction func btnBack(_ sender: Any) {
    }
    
    
    @IBAction func btnSubmit(_ sender: Any) {
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
