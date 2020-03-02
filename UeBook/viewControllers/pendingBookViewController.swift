//
//  pendingBookViewController.swift
//  UeBook
//
//  Created by Admin on 02/03/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class pendingBookViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate {
    
    var userId = String()
    @IBOutlet weak var tableView: UITableView!
    var arrpending = [AllUserPendingBooklist]()
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        PendingBook_API_Method()
        tableView.rowHeight = 140
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrpending.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
          
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingCell") as? PendingBookTableViewCell
            
            cell?.lblBookName.text = arrpending[indexPath.row].book_title
            cell?.lbluserName.text = arrpending[indexPath.row].author_name
             

            let escapedString = arrpending[indexPath.row].thubm_image
                   let fullURL = "http://" + escapedString!
                   let url = URL(string:fullURL)!


                   DispatchQueue.main.async {


                       self.getData(from: url) { data, response, error in
                           guard let data = data, error == nil else {
                               cell?.imgView?.image = #imageLiteral(resourceName: "scam_dum.png")
                               return }
                           print(response?.suggestedFilename ?? url.lastPathComponent)
                           print("Download Finished")
                           DispatchQueue.main.async() {

                              // cell?.imgView?.image = UIImage(data: data)
                               cell?.imgView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )

                           }
                       }
            }
            
            return cell!
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let bookId = self.arrpending[indexPath.row].id
                    let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kUploadBookViewController) as! UploadBookViewController

                    BookdetailVC.bookId = bookId!
                    print(BookdetailVC.bookId)
                   
                    self.present(BookdetailVC, animated: true, completion: nil)
                    
                    print("You selected cell #\(indexPath.item)!")
                }
        
        
        
            
                
       
            func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
                  }
        
    
    func PendingBook_API_Method() {
            
            
            let parameters: NSDictionary = [
               "user_id": userId
              ]
            

            ServiceManager.POSTServerRequest(String(kgetAllbookMarkByUser), andParameters: parameters as! [String : String], success: {response in
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
                                label.text = "No Pending Book"
                                self.view.addSubview(label)
                    
                             }
                              else
                             {
                                self.arrpending.removeAll()
                                     self.tableView.isHidden = false
                                     
                                     for dataCategory in BookDetailList! {
                                         
                                         self.arrpending.append(AllUserPendingBooklist(getAllUserPendingBooklist: dataCategory as! NSDictionary))
                                         
                                         
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
