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


class BookDescriptionViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,UIDocumentInteractionControllerDelegate ,WKNavigationDelegate{
    
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

    //...........................................................//
    
    var userIdbyAuthor = String()
    @IBOutlet weak var lbBookDescription: UILabel!
    
    @IBOutlet weak var lblrating: UILabel!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnUserName: UIButton!
    
    
    @IBOutlet weak var btnReadFullBook: UIButton!
    
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
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if flag == 1
        {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = self.texts[(indexPath as NSIndexPath).row]
            return cell
        }
        else
        {
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
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if flag == 1
        {
            if indexPath.row == 0
            {
                if VideoBookUrl == "nil"
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
                           if AudioBookUrl == "nil"
                           {
                                                   self.AlertVC(alertMsg:"Oops! No Audio for this Book")

                           }
                           else
                           {
                             print("*")
                           }
                       }
            if indexPath.row == 2
                       {
                           if DocumentBookUrl == "nil"
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
                                    // imgView
                                    //self.BookImage.image = UIImage(data: data)
                                    self.BookImage?.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )
                                    
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


