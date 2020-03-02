//
//  BookDescriptionViewController.swift
//  UeBook
//
//  Created by Admin on 30/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
import Popover
import MobileCoreServices
import AVFoundation
import AVKit
import WebKit
import Cosmos


class BookDescriptionViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,UIDocumentInteractionControllerDelegate ,WKNavigationDelegate,UITextViewDelegate{
    
    var reviewArr = [Allreview]()
    var assignmentArr = [AllAssignmentList]()
    @IBOutlet weak var tableView: UITableView!
    var bookId = String()
    var userId  = String()
    @IBOutlet weak var BookImage: UIImageView!
    
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var lblMostView: UILabel!
    @IBOutlet weak var btnAuthorName: UIButton!
   
    @IBOutlet weak var starView: CosmosView!
    
    
    
    @IBOutlet weak var lblTopReviews: UILabel!
    //...............popup Tableview.............................//
    
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.auto),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    fileprivate var texts = ["Video", "Audio", "Document File"]
    
    
    var flag = 0
    
    var  VideoBookUrl = String()
    var  AudioBookUrl = String()
    var  DocumentBookUrl = String()
    var webview = WKWebView()
    var ImageUrl : URL!
    var AuthorProfileUrl : URL!
    var username = String()
    //...........................................................//
    
    var userIdbyAuthor = String()
    @IBOutlet weak var lbBookDescription: UILabel!
    
    @IBOutlet weak var lblrating: UILabel!
    
    @IBOutlet weak var textviewReview: UITextView!
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnUserName: UIButton!
    var ratingValueString = "0"
    
    @IBOutlet weak var btnReadFullBook: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textviewReview.delegate = self
        
        
        textviewReview.text = "Write your Comment here"
        textviewReview.textColor = UIColor.lightGray
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        tableView.rowHeight = 150.0
        ratingView.settings.fillMode = .half
        BookDetail_API_Method()
        starView.isUserInteractionEnabled = false
        starView.settings.fillMode = .half
  
        tableView.isScrollEnabled = true
        
        
        //tableView.frame.size.height = self.scrollView.frame.height
       // tableView.estimatedRowHeight = UITableView.automaticDimension
        
        scrollView.contentSize = CGSize(width:view.frame.width, height:600)
//        let lbl = UILabel()
//        lbl.frame = CGRect(x: 15, y: 2000, width:100, height:20)
//        lbl.text = "hii"
//        scrollView.addSubview(lbl)
        ratingView.didTouchCosmos = didTouchCosmos

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                                      BookImage.addGestureRecognizer(tap)
        self.BookImage.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
                                      authorImage.addGestureRecognizer(tap2)
        self.authorImage.isUserInteractionEnabled = true

        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
     
      
                              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                         let nextViewController = storyBoard.instantiateViewController(withIdentifier:kImageZoomInZoomOutViewController ) as! ImageZoomInZoomOutViewController
                                         nextViewController.modalPresentationStyle = .overFullScreen
                                           nextViewController.imageurl = ImageUrl
                                          nextViewController.name = lblBookName.text!
                                         self.present(nextViewController, animated:true, completion:nil)
                              }
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
     
      
                              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                         let nextViewController = storyBoard.instantiateViewController(withIdentifier:kImageZoomInZoomOutViewController ) as! ImageZoomInZoomOutViewController
                                            nextViewController.modalPresentationStyle = .overFullScreen
                                           nextViewController.imageurl = AuthorProfileUrl
                                          nextViewController.name = username
                                         self.present(nextViewController, animated:true, completion:nil)
                              }

  private class func formatValue(_ value: Double) -> String {
    
     return String(format: "%.1f", value)
    
   }
    
    private func didTouchCosmos(_ rating: Double) {
      lblrating.text = BookDescriptionViewController.formatValue(rating)
      ratingValueString = BookDescriptionViewController.formatValue(rating)
        print(ratingValueString)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
      self.lblrating.text = BookDescriptionViewController.formatValue(rating)
        ratingValueString = BookDescriptionViewController.formatValue(rating)
        print(ratingValueString)
    }
    
    @IBAction func btnReadFullBook(_ sender: Any) {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-100, height: 135))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        flag = 1
        self.popover = Popover(options: self.popoverOptions)
        self.popover.willShowHandler = {
            print("willShowHandler")
        }
        self.popover.didShowHandler = {
            print("didDismissHandler")
        }
        self.popover.willDismissHandler = {
            print("willDismissHandler")
        }
        self.popover.didDismissHandler = {
            print("didDismissHandler")
        }
        self.popover.show(tableView, fromView: self.btnReadFullBook)
        
    }
    
    @IBAction func btnBookAssignment(_ sender: Any) {
        
        if assignmentArr.count == 0
        {
           self.AlertVC(alertMsg:"No Assignment for this Book")
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let nextViewController = storyBoard.instantiateViewController(withIdentifier:kBookAssignmentViewController ) as! BookAssignmentViewController
                   nextViewController.modalPresentationStyle = .overFullScreen
                   nextViewController.assignmaintArr = assignmentArr
                   self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
                
                let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
                textviewReview.layer.borderColor = myColor.cgColor
                
                textviewReview.layer.borderWidth = 2.0
                
               
                
            }
        }
        
    func textViewDidEndEditing(_ textView: UITextView) {
            
            
            let myColor = UIColor.black
            textviewReview.layer.borderColor = myColor.cgColor
            
            textviewReview.layer.borderWidth = 1.0
            
            if(textView == textviewReview)
            {
                if self.textviewReview.text?.count == 0
                {
                    
                    textviewReview.text = "Write your Comment here"
                    textviewReview.textColor = UIColor.lightGray
                    }
                
            }
            
    }
    
    @IBAction func btnUserName(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier:kUserInfoViewController ) as! UserInfoViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.valueBtn = "1"
        nextViewController.userIdbyAuthor = userIdbyAuthor
        self.present(nextViewController, animated:true, completion:nil)
        
        
    }
  
     
     
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (flag == 1)
        {
            return 3
        }
        else{

            return reviewArr.count

        }
        
    }
//    override func viewDidLayoutSubviews() {
//           super.viewDidLayoutSubviews()
//           scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
//       }
//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if flag == 1
        {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = self.texts[(indexPath as NSIndexPath).row]
            return cell
        }
        else
        {
            self.tableView.contentSize.height = CGFloat(reviewArr.count) * 150    // +40 for the header height
            tableView.translatesAutoresizingMaskIntoConstraints = true

            var frame = self.tableView.frame
            frame.size.height = self.tableView.contentSize.height
            self.tableView.frame = frame
            self.tableView.layoutIfNeeded()

            print (self.tableView.contentSize.height)

            let value = reviewArr.count
            print((value*150))
           // print (CGFloat(reviewArr.count) * 150)
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: 650 + CGFloat(value * 150) )

            print(scrollView.contentSize.height)
           self.tableView.heightAnchor.constraint(equalToConstant: self.tableView.contentSize.height).isActive = true
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as? BookDescriptionTableViewCell
            
            cell?.lblName.text = reviewArr[indexPath.row].user_name
            cell?.lblComment.text = reviewArr[indexPath.row].comment
            cell?.lbltimeDate.text = reviewArr[indexPath.row].created_at
            
            let myDouble = reviewArr[indexPath.row].rating
            let double = Double(myDouble!)
            cell?.starView.rating = double!
            cell?.starView.settings.fillMode = .half
            cell?.starView.isUserInteractionEnabled = false
            
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
                        cell?.imgView?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                       // cell?.imgView?.image = UIImage(data: data)
                        
                    }
                }
            }
            
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if flag == 1
        {
            if indexPath.row == 0
            {
                if VideoBookUrl == ""
                {
                    self.AlertVC(alertMsg:"Oops! No Video for this Book")
                }
                else
                {
                    
                    let stringUrl = "https://" + VideoBookUrl
                    let videoURL = URL(string:stringUrl)
                    let player = AVPlayer(url:videoURL!)  // video path coming from above function

                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true) {
                        playerViewController.player!.play()
                    }
                }
            }
            if indexPath.row == 1
                       {
                           if AudioBookUrl == ""
                           {
                                                   self.AlertVC(alertMsg:"Oops! No Audio for this Book")

                           }
                           else
                           {
                             let stringUrl = "https://" + AudioBookUrl
                             let videoURL = URL(string:stringUrl)
                             let player = AVPlayer(url:videoURL!)  // video path coming from above function

                             let playerViewController = AVPlayerViewController()
                             playerViewController.player = player
                             self.present(playerViewController, animated: true) {
                                 playerViewController.player!.play()
                           }
                       }
            }
            if indexPath.row == 2
                       {
                           if DocumentBookUrl == ""
                           {
                                                   self.AlertVC(alertMsg:"Oops! No Document File for this Book")

                           }
                           else
                           {
                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                   let nextViewController = storyBoard.instantiateViewController(withIdentifier:kWebDocmentViewController ) as! WebDocmentViewController
                                   nextViewController.modalPresentationStyle = .overFullScreen
                                   nextViewController.DocumentBookUrl = DocumentBookUrl
                                 
                                   self.present(nextViewController, animated:true, completion:nil)
                            
                            
                            
                            
                            
                        
                           }
                       }
        }
    }
    
    
    
    @IBAction func btnBack(_ sender: Any) {
 
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func AlertVC(alertMsg:String) {
        
        let alert = UIAlertController(title: alertMsg, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        present(alert, animated: true, completion: nil)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

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
                        self.username = objBookDetail.user_name!
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
                        self.lblMostView.text = objBookDetail.mostView! + " Reviews "
                        
                    }
                    
                    
                    if objBookDetail.video_url == nil
                    {
                        self.VideoBookUrl = "nil"
                    }
                    else
                    {
                        self.VideoBookUrl = objBookDetail.video_url!
                    }
                    if objBookDetail.audio_url == nil
                    {
                        self.AudioBookUrl = "nil"
                    }
                    else
                    {
                        self.AudioBookUrl = objBookDetail.audio_url!
                    }
                    if objBookDetail.pdf_url == nil
                    {
                        self.DocumentBookUrl = "nil"
                    }
                    else
                    {
                        self.DocumentBookUrl = objBookDetail.pdf_url!
                    }
                    if objBookDetail.profile_pic == nil
                    {
                        self.authorImage.layer.cornerRadius = self.authorImage.frame.width/2
                                               self.authorImage.layer.borderColor = UIColor.white.cgColor
                                               self.authorImage.layer.borderWidth = 2
                        self.authorImage.image = #imageLiteral(resourceName: "user_default")
                    }
                    else{
                        self.authorImage.layer.cornerRadius = self.authorImage.frame.width/2
                        self.authorImage.layer.borderColor = UIColor.white.cgColor
                        self.authorImage.layer.borderWidth = 2
                        
                        let escapedString = objBookDetail.profile_pic
                        let fullURL = "http://" + escapedString!
                        let url = URL(string:fullURL)!
                        self.AuthorProfileUrl = url
                        
                        DispatchQueue.main.async {
                            
                            
                            self.getData(from: url) { data, response, error in
                                guard let data = data, error == nil else {
                                    self.authorImage.image = #imageLiteral(resourceName: "noimage")
                                    return }
                                print(response?.suggestedFilename ?? url.lastPathComponent)
                                print("Download Finished")
                                DispatchQueue.main.async() {
                                    // imgView
                                    //self.BookImage.image = UIImage(data: data)
                                    self.authorImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                                    
                                }
                            }
                        }
                    }
                    
                    if objBookDetail.thubm_image == ""
                    {
                        
                    }
                        
                        
                    else
                    {
                        self.BookImage.layer.cornerRadius = 5
                        
                        let escapedString = objBookDetail.thubm_image
                        let fullURL = "http://" + escapedString!
                        let url = URL(string:fullURL)!
                        
                        self.ImageUrl = url
                        DispatchQueue.main.async {
                            
                            
                            self.getData(from: url) { data, response, error in
                                guard let data = data, error == nil else {
                                    self.BookImage.image = #imageLiteral(resourceName: "noimage")
                                    return }
                                print(response?.suggestedFilename ?? url.lastPathComponent)
                                print("Download Finished")
                                DispatchQueue.main.async() {
                                    // imgView
                                    //self.BookImage.image = UIImage(data: data)
                                    self.BookImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )
                                    
                                }
                            }
                        }
                    }
                    
                    
                }
                //........................
                
                
                let reviewList = response? ["review"] as? NSArray
                
                
                
                if reviewList == nil || reviewList?.count == 0 {
                    
                    //self.noDataFoundLbl.isHidden = false
                    self.tableView.isHidden = true
                    self.lblTopReviews.isHidden = true
                }
                else {
                    self.reviewArr.removeAll()
                    self.tableView.isHidden = false
                    self.lblTopReviews.isHidden = false
                    
                    for dataCategory in reviewList! {
                        
                        self.reviewArr.append(Allreview(getReviewListData: dataCategory as! NSDictionary))
                        
                        
                    }
                    
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    
                }
                
                
                let assignmentList = response? ["assignment"] as? NSArray
                
                if assignmentList == nil || assignmentList?.count == 0 {
               
                }
                else {
                    self.assignmentArr.removeAll()
                   
                    
                    for dataCategory in assignmentList! {
                        
                        self.assignmentArr.append(AllAssignmentList(getAssignmentListData: dataCategory as! NSDictionary))
                        
                        
                    }
               
                    
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
    
 
    
  
    func addReview_API_Method() {
        
        
        let parameters: NSDictionary = [
           "user_id": userId,
            "books_id": bookId,
            "comment": textviewReview.text as Any,
            "rating": ratingValueString,
            ]
        

        ServiceManager.POSTServerRequest(String(kaddReview), andParameters: parameters as! [String : String], success: {response in
            print("response-------",response!)
            //self.HideLoader()
            if response is NSDictionary {
               let statusCode = response?["error"] as? Int
                                        if statusCode == 1 {
                                          //  self.AlertVC(alertMsg:msg!)
                                        }
                                        else if statusCode == 0
                                        {
                                            
                                            self.BookDetail_API_Method()
                                            
                                       }
                
               
                
                
                    
                
            }
        }, failure: { error in
            //self.HideLoader()
        })
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if textviewReview.textColor == UIColor.lightGray || textviewReview.text == nil {
             self.AlertVC(alertMsg:"Please Enter your Comment")
        }
        if ratingValueString == "0"
        {
              self.AlertVC(alertMsg:"Please Rate this book")
        }
        else
        {
            addReview_API_Method()
        }
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


