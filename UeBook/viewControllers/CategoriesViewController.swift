//
//  CategoriesViewController.swift
//  UeBook
//
//  Created by Admin on 10/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    class func instance()->UIViewController{
        let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kCategoriesViewController)
        let nav = UINavigationController(rootViewController: colorController)
        nav.navigationBar.isTranslucent = false
        return nav
    }
    
    var userId =  String()
   var CategiesArr = [AllCategory]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationHide()
         userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
           Categries_API_Method()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 145
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategiesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategiesCell") as? CategiesTableViewCell
        
        cell?.lblCategiresName.text =  CategiesArr[indexPath.row].category_name
        cell?.lblNumberOfBooks.text =  "50 Books"

        cell!.layer.borderColor = UIColor.clear.cgColor
        cell?.backgroundColor = UIColor.clear


        
        return cell!
        
    }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             let CategoryId = CategiesArr[indexPath.row].id
            let BookByTypeVC = self.storyboard?.instantiateViewController(withIdentifier: kBooksByTypesViewController) as! BooksByTypesViewController

            BookByTypeVC.category_id = CategoryId!
           BookByTypeVC.categoryName = CategiesArr[indexPath.row].category_name!
            BookByTypeVC.modalPresentationStyle = .overFullScreen

    //        self.navigationController?.pushViewController(BookdetailVC, animated: true)
            self.present(BookByTypeVC, animated: true, completion: nil)
            
            print("You selected cell #\(indexPath.item)!")
        }
    func Categries_API_Method() {
                  
                  
        let parameters: NSDictionary = [:]
                  

                  ServiceManager.POSTServerRequest(String(kgetAllCategory), andParameters: parameters as! [String : String], success: {response in
                      print("response-------",response!)
                      //self.HideLoader()
                      if response is NSDictionary {
                         // let statusCode = response?["error"] as? Int
                          let message = response? ["message"] as? String
                          let AllCategoryList = response?["response"] as? NSArray

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
                                           self.CategiesArr.removeAll()
                                           self.tableView.isHidden = false

                                           for dataCategory in AllCategoryList! {

                                               self.CategiesArr.append(AllCategory(getAllCategory: dataCategory as! NSDictionary))
                                               print(self.CategiesArr.count)
                                              
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
