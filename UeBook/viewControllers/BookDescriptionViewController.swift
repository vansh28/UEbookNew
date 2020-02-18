//
//  BookDescriptionViewController.swift
//  UeBook
//
//  Created by Admin on 30/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BookDescriptionViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    var reviewArr = [Allreview]()
    
    @IBOutlet weak var tableView: UITableView!
    var bookId = String()
    var userId  = String()
    @IBOutlet weak var BookImage: UIImageView!
    
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var lblMostView: UILabel!
    @IBOutlet weak var btnAuthorName: UIButton!
    @IBOutlet weak var starView: StarsView!
    
    var userIdbyAuthor = String()
    @IBOutlet weak var lbBookDescription: UILabel!
    
    @IBOutlet weak var lblrating: UILabel!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnUserName: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        tableView.rowHeight = 150.0
        
        BookDetail_API_Method()
        
        tableView.isScrollEnabled = false

        
        //tableView.frame.size.height = self.scrollView.frame.height
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        scrollView.contentSize = CGSize(width:view.frame.width, height:1000)
       let lbl = UILabel()
        lbl.frame = CGRect(x: 15, y: 2000, width:100, height:20)
        lbl.text = "hii"
        scrollView.addSubview(lbl)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArr.count
    }
    
    @IBAction func btnUserName(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier:kUserInfoViewController ) as! UserInfoViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.valueBtn = "1"
        nextViewController.userIdbyAuthor = userIdbyAuthor
        self.present(nextViewController, animated:true, completion:nil)
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var frame = self.tableView.frame
        frame.size.height = self.tableView.contentSize.height
        self.tableView.frame = frame
      self.tableView.layoutIfNeeded()

        print (self.tableView.contentSize.height)
    
       scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: self.scrollView.contentSize.height + self.tableView.contentSize.height )
        
        self.tableView.heightAnchor.constraint(equalToConstant: self.tableView.contentSize.height).isActive = true
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as? BookDescriptionTableViewCell
        
        cell?.lblName.text = reviewArr[indexPath.row].user_name
        cell?.lblComment.text = reviewArr[indexPath.row].comment
        cell?.lbltimeDate.text = reviewArr[indexPath.row].created_at
       
        let myDouble = reviewArr[indexPath.row].rating
        let double = Double(myDouble!)
        cell?.starView.rating = double!
       //  tableView.rowHeight = UITableView.automaticDimension

        
        cell?.layer.masksToBounds = true
        cell?.imgView.layer.cornerRadius = ((cell?.imgView.frame.size.width)!)/2
       
        let escapedString = reviewArr[indexPath.row].url
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
   
    @IBAction func btnBack(_ sender: Any) {
//                let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kBookMarkViewController) as! BookMarkViewController
//
//                 BookdetailVC.userId = userId
//                print(BookdetailVC.userId)
//                BookdetailVC.modalPresentationStyle = .overFullScreen
//
//
//                self.present(BookdetailVC, animated: true, completion: nil)
        
        
        self.dismiss(animated: true, completion: nil)

                
            }
        
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
//    private func tableView(tableView: UITableView,
//           heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//       {
//
//        return UITableView.automaticDimension;
//       }
    func BookDetail_API_Method()
       {
          


           let dictionary: NSDictionary = [
               "book_id" : bookId,
               "user_id" : userId
               
           ]
           ServiceManager.POSTServerRequest(String(kgetBookDetail), andParameters: dictionary as! [String : String], success: {response in
               
               print("response-------",response!)
             //  self.HideLoader()
               if response is NSDictionary {
                   let msg = response?["message"] as? String
                   let averaVal = response?["averaVal"] as? Double
                   let BookDetailList = response?["data"] as? NSDictionary
                   
                   let statusCode = response?["error"] as? Int
                // rating
               if BookDetailList == nil || BookDetailList?.count == 0 {
               }
                else
               {
                self.starView.rating = averaVal!
                self.lblrating.text = String(averaVal!)
                
                }
                
                
                   //.......bookDetail.........
                   if BookDetailList == nil || BookDetailList?.count == 0 {
                    }
                else {
                    let objBookDetail = AllBookDescription(getBookDescriptionData: BookDetailList!)
                    self.userIdbyAuthor = objBookDetail.user_id!
                    if objBookDetail.book_title == nil
                    {
                        self.lblBookName.text = ""
                    }
                    else{
                        self.lblBookName.text =  objBookDetail.book_title
                    
                    }
                    
                    if objBookDetail.user_name == nil
                    {
                        self.btnAuthorName.setTitle("", for: .normal)
                        
                    }
                    else{
                        self.btnAuthorName.setTitle(objBookDetail.user_name, for: .normal)
                    }
                    
                    if objBookDetail.book_description == nil
                    {
                        self.lbBookDescription.text = ""
                        
                    }
                    else{
                        self.lblBookName.sizeToFit()
                        self.lbBookDescription.text = objBookDetail.book_description
                    }
                    
                    if objBookDetail.mostView == nil
                    {
                        self.lblMostView.text = ""
                        
                    }
                    else{
                        self.lblMostView.text = objBookDetail.mostView! + " Reviews "                    }
                    
                    if objBookDetail.thubm_image == ""
                    {
                        
                    }
                   
                    else
                    {
                        self.BookImage.layer.cornerRadius = 5
                        
                        let escapedString = objBookDetail.thubm_image
                                let fullURL = "http://" + escapedString!
                                let url = URL(string:fullURL)!
                                
                                
                                DispatchQueue.main.async {
                                    
                                    
                                    self.getData(from: url) { data, response, error in
                                        guard let data = data, error == nil else {
                                            self.BookImage.image = #imageLiteral(resourceName: "noimage")
                                            return }
                                        print(response?.suggestedFilename ?? url.lastPathComponent)
                                        print("Download Finished")
                                        DispatchQueue.main.async() {
                                            
                                            self.BookImage.image = UIImage(data: data)
                                            
                                        }
                                    }
                                }
                    }
                    
                    
//                    if objBookDetail.profile_pic == ""
//                                       {
//                                           self.authorImage.image = #imageLiteral(resourceName: "noimage")
//                                       }
//
//                                       else
//                                       {
//                                           self.authorImage.layer.cornerRadius = 2
//
//                                           let escapedString = objBookDetail.profile_pic
//                                                   let fullURL = kImageUploadURL + escapedString!
//                                                   let url = URL(string:fullURL)!
//
//
//                                                   DispatchQueue.main.async {
//
//
//                                                       self.getData(from: url) { data, response, error in
//                                                           guard let data = data, error == nil else {
//                                                               self.authorImage.image = #imageLiteral(resourceName: "noimage")
//                                                               return }
//                                                           print(response?.suggestedFilename ?? url.lastPathComponent)
//                                                           print("Download Finished")
//                                                           DispatchQueue.main.async() {
//
//                                                               self.authorImage.image = UIImage(data: data)
//
//                                                           }
//                                                       }
//                                                   }
//                                       }
                    
                }
                   //........................

                    
                    let reviewList = response? ["review"] as? NSArray

                    
                    
                    if reviewList == nil || reviewList?.count == 0 {
                        
                        //self.noDataFoundLbl.isHidden = false
                        self.tableView.isHidden = true
                    }
                    else {
                        self.reviewArr.removeAll()
                        self.tableView.isHidden = false
                        
                        for dataCategory in reviewList! {
                            
                            self.reviewArr.append(Allreview(getReviewListData: dataCategory as! NSDictionary))
                            
                            
                        }
                       
                        self.tableView.dataSource = self
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
          
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
