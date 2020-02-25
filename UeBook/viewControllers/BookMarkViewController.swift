//
//  BookMarkViewController.swift
//  UeBook
//
//  Created by Admin on 10/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BookMarkViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    class func instance()->UIViewController{
              let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kBookMarkViewController)
              let nav = UINavigationController(rootViewController: colorController)
              nav.navigationBar.isTranslucent = false
              return nav
          }

    var userId = String()
     var BookMarkArr = [AllbookMarkByUser]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationHide()

        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!

        print (userId)
        BookMark_API_Method()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        // Do any additional setup after loading the view.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookMarkArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell") as? BookMarkTableViewCell
        
        cell?.lblBookName.text = BookMarkArr[indexPath.row].book_title
        cell?.lblUserName.text = BookMarkArr[indexPath.row].author_name
        

        let myDouble = BookMarkArr[indexPath.row].rating
        let double = Double(myDouble!)
        cell?.starView.rating = double!
      
//        cell?.layer.masksToBounds = true
//        cell?.imgView.layer.cornerRadius = ((cell?.imgView.frame.size.width)!)/2

        let escapedString = BookMarkArr[indexPath.row].thubm_image
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
        let bookId = self.BookMarkArr[indexPath.row].id
                let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kBookDescriptionViewController) as! BookDescriptionViewController

                BookdetailVC.bookId = bookId!
                print(BookdetailVC.bookId)
               // BookdetailVC.modalPresentationStyle = .overFullScreen
                   kBookDescriptionViewController
        //        self.navigationController?.pushViewController(BookdetailVC, animated: true)
                self.present(BookdetailVC, animated: true, completion: nil)
                
                print("You selected cell #\(indexPath.item)!")
            }
    
    
    
        
            
   
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                  URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
              }
    func BookMark_API_Method() {
        
        
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
                            label.text = "No Bookmark List"
                            self.view.addSubview(label)
                
                         }
                          else
                         {
                            self.BookMarkArr.removeAll()
                                 self.tableView.isHidden = false
                                 
                                 for dataCategory in BookDetailList! {
                                     
                                     self.BookMarkArr.append(AllbookMarkByUser(getAllbookMarkByUser: dataCategory as! NSDictionary))
                                     
                                     
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
