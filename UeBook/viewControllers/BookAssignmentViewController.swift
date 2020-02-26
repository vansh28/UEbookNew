//
//  BookAssignmentViewController.swift
//  UeBook
//
//  Created by Admin on 25/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BookAssignmentViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
   
    struct Objects {

        var sectionName : String!
        var sectionObjects : String!
    }

    var bookId  = String()
    var questionList = String()
    var id = String()
    var assignmaintArr = [AllAssignmentList]()
    @IBOutlet weak var tableView: UITableView!
    var listOfTextFields : [UITextView] = []
    var arrtextValue = [Objects]()
   
   var userId = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 210
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        // Do any additional setup after loading the view.
    }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return assignmaintArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
          
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell") as? BookAssignmentTableViewCell
            
            cell?.lblQuestion.text = assignmaintArr[indexPath.row].question
            
            cell!.textChanged {[weak tableView] (_) in
                DispatchQueue.main.async {
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
            }
            listOfTextFields.append(cell!.textViewAnswer)
            
            return cell!
            
        }
    
    func json(from object:Array<Any>) -> String? {
           guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
               return nil
           }
           return String(data: data, encoding: String.Encoding.utf8)
             // print("\(json(from:array as Any))")
       }

    
       func getInputsValue(_ inputs:[UITextField], seperatedby value: String) -> String {
           return inputs.sorted {$0.tag <  $1.tag}.map {$0.text}.compactMap({$0}).joined(separator: value)
       }
       
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        print (listOfTextFields.count)
                  for i in 0 ... listOfTextFields.count {
                  
                    if i < listOfTextFields.count && !(listOfTextFields[i].text!.isEmpty) && !(listOfTextFields[i].textColor == UIColor.lightGray) {
                        let parameters: [String: String] = ["books_id":assignmaintArr[i].book_id! , "assignment_id": assignmaintArr[i].id! ,"anwser" :listOfTextFields[i].text!,"answered_by":userId]
                                          
                     
                          for (key, value) in parameters {
                          print("\(key) : \(value)")
                          arrtextValue.append(Objects(sectionName: key, sectionObjects: value))
                          }
                        print(arrtextValue.count)
                      }
                      }
        

        }

                
    
   
    func BookAssignment_API_Method() {
        
        
        let parameters: NSDictionary = [
            "answer": ""
            
            
         
        ]
        

        ServiceManager.POSTServerRequest(String(kanswerQuestion), andParameters: parameters as! [String : String], success: {response in
            print("response-------",response!)
            //self.HideLoader()
            if response is NSDictionary {
               // let statusCode = response?["error"] as? Int
                let message = response? ["message"] as? String
              //  let resposeArr = response?["response"] as? [[String: AnyObject]]
                
                
                
                    
            
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
