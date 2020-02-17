//
//  ReadBookViewController.swift
//  UeBook
//
//  Created by Admin on 27/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class ReadBookViewController:  PagerController, PagerDataSource, PagerDelegate ,UITableViewDelegate ,UITableViewDataSource {
   
    
    private lazy var FirstVC: UploadBookViewController = {
              return UploadBookViewController(nibName: "UploadBookViewController", bundle: nil)
          }()
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    var CategiesArr = [AllCategory]()
    var category_id = String()
    var BooksByTypesArr  = [AllBooksByTypes]()

       
       var selectedIndexPath = IndexPath(row: 0, section: 0)
       var selectedAttributesIndexPath = IndexPath(row: 0, section: 1)
       
       let largerRedTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                      NSAttributedString.Key.foregroundColor: UIColor.red]
       let largerRedTextHighlightAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                               NSAttributedString.Key.foregroundColor: UIColor.blue]
       let largerRedTextSelectAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                            NSAttributedString.Key.foregroundColor: UIColor.orange]
       
 


    override func viewDidLoad() {
      
       
        super.viewDidLoad()
        Categries_API_Method()
        
        
        
        segmentedControl.segmentStyle = .textOnly
//        let items = CategiesArr
//        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.insertSegment(withTitle: "Recommended", at: 0)
        segmentedControl.insertSegment(withTitle: "New Books",  at: 1)
        segmentedControl.insertSegment(withTitle: "Sport", at: 2)
        segmentedControl.insertSegment(withTitle: "Music", at: 3)
        segmentedControl.insertSegment(withTitle: "Stroy", at: 4)
        segmentedControl.insertSegment(withTitle: "dev test", at: 5)
            
        segmentedControl.underlineSelected = true
    
            
       segmentedControl.addTarget(self, action: #selector(ReadBookViewController.segmentSelected(sender:)), for: .valueChanged)

        // change some colors
        let myColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)

        segmentedControl.segmentContentColor = myColor
        segmentedControl.selectedSegmentContentColor = UIColor.white
        segmentedControl.fixedSegmentWidth = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight  = 164
        

    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        category_id = CategiesArr[sender.selectedSegmentIndex].id!
        BookByType_API_Method()
        
        
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let segmentedControlAppearance = ScrollableSegmentedControl.appearance()
        segmentedControlAppearance.segmentContentColor = UIColor.white
        segmentedControlAppearance.selectedSegmentContentColor = UIColor.darkText
       // segmentedControlAppearance.backgroundColor = UIColor.black

        return true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

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
                                        self.category_id = self.CategiesArr[0].id!

                                        self.BookByType_API_Method()
                                        
                                        
                                        self.tableView.reloadData()
                                        
                                    
                                        
                                          }
                             
                                     
                             
                                 
                             
                         }
                     }, failure: { error in
                         //self.HideLoader()
                     })
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return BooksByTypesArr.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "ReadBookCell") as? ReadBookTableViewCell
        cell?.lblBookName.text = BooksByTypesArr[indexPath.row].book_title
        cell?.lblUserName.text = BooksByTypesArr[indexPath.row].author_name
         let myDouble = BooksByTypesArr[indexPath.row].rating
        
        if myDouble == nil
        {
            cell?.starView.rating = 0
        }
        else
        {
                let double = Double(myDouble!)
                
                cell?.starView.rating = double!
        }
        
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

                                   cell?.imgView?.image = UIImage(data: data)

                               }
                           }
                }

               
               return cell!

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
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
                  }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//               let CategoryId = CategiesArr[indexPath.row].id
//              let BookByTypeVC = self.storyboard?.instantiateViewController(withIdentifier: kBooksByTypesViewController) as! BooksByTypesViewController
//
//              BookByTypeVC.category_id = CategoryId!
//             BookByTypeVC.categoryName = CategiesArr[indexPath.row].category_name!
//              BookByTypeVC.modalPresentationStyle = .overFullScreen
//
//      //        self.navigationController?.pushViewController(BookdetailVC, animated: true)
//              self.present(BookByTypeVC, animated: true, completion: nil)
//              
//              print("You selected cell #\(indexPath.item)!")
//          }
    
    func customizeTab() {
        indicatorColor = .blue
        tabsViewBackgroundColor = UIColor.gray.withAlphaComponent(0.1)
        contentViewBackgroundColor = UIColor.gray.withAlphaComponent(0.32)
        
        startFromSecondTab = false
        centerCurrentTab = true
        tabLocation = PagerTabLocation.top
        tabHeight = 49
        tabOffset = 36
        tabWidth = UIScreen.main.bounds.size.width/3
        fixFormerTabsPositions = false
        fixLaterTabsPosition = false
        animation = PagerAnimation.during
        selectedTabTextColor = .blue
        tabsTextColor = .black
        tabTopOffset = 0
        indicatorHeight = 2.0
        isRTL = false
    }
    func didChangeTabToIndex(_ pager: PagerController, index: Int){
           print("selected tab index is \(index)")
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
