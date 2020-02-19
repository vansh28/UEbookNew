//
//  BooksByTypesViewController.swift
//  UeBook
//
//  Created by Admin on 13/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BooksByTypesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    

    @IBOutlet weak var lblTopHeading: UILabel!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var category_id = String()
    var categoryName   = String()
    var BooksByTypesArr  = [AllBooksByTypes]()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        BookByType_API_Method()
        lblTopHeading.text = categoryName
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight  = 164
        
        // Do any additional setup after loading the view.
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BooksByTypesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "BookTypeCell") as? BooksByTypesTableViewCell
               
        cell?.lblBookName.text = BooksByTypesArr[indexPath.row].book_title
        cell?.lblUserName.text = BooksByTypesArr[indexPath.row].author_name
         let myDouble = BooksByTypesArr[indexPath.row].rating
        
        if myDouble == nil
        {
            cell?.starview.rating = 0
        }
        else
        {
                let double = Double(myDouble!)
                
                cell?.starview.rating = double!
        }
        //        cell?.layer.masksToBounds = true
        //        cell?.imgView.layer.cornerRadius = ((cell?.imgView.frame.size.width)!)/2

                let escapedString = BooksByTypesArr[indexPath.row].thubm_image
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
                                cell?.imgView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )

                                  // cell?.imgView?.image = UIImage(data: data)

                               }
                           }
                }

               
               return cell!
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                   URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
               }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bookId = BooksByTypesArr[indexPath.row].id
                let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kBookDescriptionViewController) as! BookDescriptionViewController

                BookdetailVC.bookId = bookId!
                print(BookdetailVC.bookId)
                BookdetailVC.modalPresentationStyle = .overFullScreen

        //        self.navigationController?.pushViewController(BookdetailVC, animated: true)
                self.present(BookdetailVC, animated: true, completion: nil)
                
                print("You selected cell #\(indexPath.item)!")
        
        
        print("value")
    }
    @IBAction func btnBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    func BookByType_API_Method() {
              
              
    let parameters: NSDictionary = [
        "category_id": category_id
        
        ]
              

              ServiceManager.POSTServerRequest(String(kgetBooksByTypes), andParameters: parameters as! [String : String], success: {response in
                  print("response-------",response!)
                  //self.HideLoader()
                  if response is NSDictionary {
                     // let statusCode = response?["error"] as? Int
                      let message = response? ["message"] as? String
                      let AllCategoryList = response?["data"] as? NSArray

                       print("response-------",response!)
                             
                               if AllCategoryList == nil || AllCategoryList?.count == 0 {
                                  
                                  self.tableView.isHidden = true
                                 
                                  let label = UILabel(frame: CGRect(x: 120, y:self.tableView.frame.size.height/2, width: 200, height: 21))
                                  let color = UIColor(red: (95.0/255), green: (122.0/255), blue: (134.0/255), alpha: 1.0)

                                  label.textColor = color
                                //  label.backgroundColor = .gray
                                  label.font = UIFont.boldSystemFont(ofSize:20.0)
                                 // label.center = CGPoint(x: 160, y: 285)
                                  label.textAlignment = .left
                                  label.text = "No Notepad List"
                                  self.view.addSubview(label)
                      
                               }
                                else
                               {
                                       self.BooksByTypesArr.removeAll()
                                       self.tableView.isHidden = false

                                       for dataCategory in AllCategoryList! {

                                           self.BooksByTypesArr.append(AllBooksByTypes(getBooksByTypes: dataCategory as! NSDictionary))
                                           print(self.BooksByTypesArr.count)
                                          
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
