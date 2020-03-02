//
//  UploadBookViewController.swift
//  UeBook
//
//  Created by Admin on 23/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Photos
import AVKit
import AVFoundation
import MobileCoreServices
import Alamofire

import UIKit
import PDFKit
//import MediaPlayer




class UploadBookViewController: UIViewController ,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource  , AVAudioRecorderDelegate, AVAudioPlayerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate {
    
    
    var bookId = String()
    //viedo upload
    var imagePickerController = UIImagePickerController()
    var videoURL : NSURL?
    var audioRecorder:AVAudioRecorder!
    
    var coverImage :UIImage!
    @IBOutlet weak var lblbookAssigmant: UILabel!
    var audioStr = String()
    @IBOutlet weak var btnAdd: UIButton!
    var VideoUrl :URL!
    var AudioUrl : URL!
    @IBOutlet weak var imageUploadCoverImage: UIImageView!
    @IBOutlet weak var imageViedo: UIImageView!
    //
    @IBOutlet weak var viewRoundedView: RoundedView!
    var imageData : Data!
    var url: URL?
    let  videoUrl = "https://api.example/video... "
    @IBOutlet weak var viewimage: UIView!
    var value:Int = 0
    var imagePicker = UIImagePickerController()
    
    var activeDataArray = [String]()
    
    
    
    //.........link................//
    @IBOutlet weak var btnImageLink: UIButton!
    
    @IBOutlet weak var btnPdfLink: UIButton!
    var btnUrl :URL?
    
    @IBOutlet weak var btnAudioLink: UIButton!
    //........................//
    
    let buttonPadding:CGFloat = 30
    var yOffset:CGFloat = 10
    var  QuestionValue:Int = 1
    var txtAddQuestion = UITextField()
    var lblAddQuestion = UILabel()
    var arrtextValue = [String]()
    var CategiesArr = [AllCategory]()
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var category_Id  = String()
    var strRecommmended = ["Recommmended","New Books", " Sport", "Music","Story","Dev test"] //multi-season
    var flag = 0
    var filePathG  :URL?
    var fileDocPath : URL?
    var fileAudioPath : URL?
    var  ServerRestFlag = 0
    @IBOutlet weak var scrollView: UIScrollView!
    
    //upload book
    @IBOutlet weak var btnSaveForLater: UIButton!
    
    
    @IBOutlet weak var btnPublish: UIButton!
    
    
    @IBOutlet weak var txtbookTitle: UITextField!
    @IBOutlet weak var txtBookAuthor: UITextField!
    @IBOutlet weak var textViewBookDescription: UITextView!
    @IBOutlet weak var txtRecommended: UITextField!
    
    @IBOutlet weak var btnUploadCoverImage: UIButton!
    
    @IBOutlet weak var viewQuestion: UIView!
    //
    
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    
    @IBOutlet weak var viewUploadMore: UIView!
    
    
    
    @IBOutlet weak var btnViedoUpload: UIButton!
    @IBOutlet weak var view1: UIView!
    // TextFiled Array
    
    var listOfTextFields : [UITextField] = []
    //
    
    @IBOutlet weak var lblQuestionCount: UILabel!
    
    @IBOutlet weak var txtEnterQuestion: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Categries_API_Method()
        viewimage.isHidden = true
        imagePicker.delegate = self
        
        
        btnPdfLink.isHidden = true
        btnImageLink.isHidden = true
        btnAudioLink.isHidden = true
        
        imageUploadCoverImage.isHidden = true
        
        lblbookAssigmant.frame =  CGRect(x: lblbookAssigmant.frame.origin.x, y: 379, width: lblbookAssigmant.frame.width, height: lblbookAssigmant.frame.size.height)
        btnAdd.frame = CGRect(x: btnAdd.frame.origin.x, y: 379, width: btnAdd.frame.size.width, height: lblbookAssigmant.frame.size.height)
        
        // imageViedo.isHidden = true
        
        addQuestionTextField()
        view1.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width:view.frame.width, height: 800)
        
        txtbookTitle.delegate=self
        //   txtEnterQuestion.delegate=self
        txtBookAuthor.delegate=self
        textViewBookDescription.delegate=self
        txtAddQuestion.isUserInteractionEnabled = true
        
        txtAddQuestion.delegate = self
        txtbookTitle.layer.cornerRadius = 5
        txtbookTitle.layer.borderWidth = 1.0
        txtbookTitle.layer.borderColor = UIColor.gray.cgColor
        txtbookTitle.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        //               txtEnterQuestion.layer.cornerRadius = 5
        //               txtEnterQuestion.layer.borderWidth = 1.0
        //               txtEnterQuestion.layer.borderColor = UIColor.gray.cgColor
        //               txtEnterQuestion.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        txtBookAuthor.layer.cornerRadius = 5
        txtBookAuthor.layer.borderWidth = 1.0
        txtBookAuthor.layer.borderColor = UIColor.gray.cgColor
        txtBookAuthor.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        txtRecommended.layer.cornerRadius = 5
        txtRecommended.layer.borderWidth = 1.0
        txtRecommended.layer.borderColor = UIColor.gray.cgColor
        txtRecommended.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        
        
        
        textViewBookDescription.layer.cornerRadius = 5
        let myColor = UIColor.gray
        textViewBookDescription.layer.borderColor = myColor.cgColor
        textViewBookDescription.layer.borderWidth = 1.0
        textViewBookDescription.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        
        
        txtbookTitle.placeholder="Book Title"
        lblBookTitle.isHidden = true
        
        txtBookAuthor.placeholder="Book Author"
        lblAuthor.isHidden = true
        
        
        
        textViewBookDescription.text = "Book Description"
        textViewBookDescription.textColor = UIColor.lightGray
        lblDescription.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imageUploadCoverImage.addGestureRecognizer(tap)
        self.imageUploadCoverImage.isUserInteractionEnabled = true
        
        
        
        
        
        
    }
    
    
    
    // ...........link.........
    @IBAction func btnImageLink(_ sender: Any) {
        
        
        viedoupload()
        
    }
    
    @IBAction func btnPdfLink(_ sender: Any) {
        
        let dc = UIDocumentInteractionController(url: fileDocPath!)
        dc.delegate = self
        dc.presentPreview(animated: true)
    }
    //MARK: UIDocumentInteractionController delegates
    
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
    
    
    
    @IBAction func btnAudioLink(_ sender: Any) {
        
        
        btnAudioLink.setTitle("Audio.link", for:.normal)
        let player = AVPlayer(url: AudioUrl!)  // video path coming from above function
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    
    func viedoupload()
    {
        
        let player = AVPlayer(url: filePathG!)  // video path coming from above function
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        
    }
    
    
    
    
    //..............link.....................
    
    @IBAction func btnSaveForLater(_ sender: Any) {
    }
    @IBAction func btnRecommended(_ sender: Any) {
        activeDataArray = strRecommmended
        pickerview()
        
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
    
    
    
    func pickerview()
    {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CategiesArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return(CategiesArr[row].category_name)
        
        ///return(activeDataArray[row])
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(activeDataArray[row])
        txtRecommended.text = ""
        txtRecommended.text = CategiesArr[row].category_name
        category_Id = CategiesArr[row].id!
        
        print (category_Id)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            
            let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
            textViewBookDescription.layer.borderColor = myColor.cgColor
            
            textViewBookDescription.layer.borderWidth = 2.0
            
            self.lblDescription.isHidden=false
            
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationHide()
        
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        let myColor = UIColor.black
        textViewBookDescription.layer.borderColor = myColor.cgColor
        
        textViewBookDescription.layer.borderWidth = 1.0
        
        if(textView == textViewBookDescription)
        {
            if self.textViewBookDescription.text?.count == 0
            {
                
                textViewBookDescription.text = "Book Description"
                textViewBookDescription.textColor = UIColor.lightGray
                lblDescription.isHidden = true
            }
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        //activeDataArray = []
        
        
        
        
        if(textField == txtbookTitle)
        {
            txtbookTitle.placeholder = ""
            self.lblBookTitle.isHidden=false
            
            let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
            txtbookTitle.layer.borderColor = myColor.cgColor
            
            txtbookTitle.layer.borderWidth = 2.0
            
        }
        else if(textField == txtBookAuthor)
        {
            txtBookAuthor.placeholder = ""
            self.lblAuthor.isHidden=false
            
            let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
            txtBookAuthor.layer.borderColor = myColor.cgColor
            
            txtBookAuthor.layer.borderWidth = 2.0
            
        }
        else if(textField == txtEnterQuestion)
        {
            txtEnterQuestion.placeholder = ""
            self.lblQuestion.isHidden=false
            
            let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
            txtEnterQuestion.layer.borderColor = myColor.cgColor
            
            txtEnterQuestion.layer.borderWidth = 2.0
            
        }
        //            else if(textField == txtAddQuestion)
        //                       {
        //                           txtAddQuestion.placeholder = ""
        //                           self.lblQuestion.isHidden=false
        //
        //                           let myColor = UIColor(red: 95/255, green: 121/255, blue: 134/255, alpha: 1)
        //                           txtAddQuestion.layer.borderColor = myColor.cgColor
        //
        //                           txtAddQuestion.layer.borderWidth = 2.0
        //
        //                       }
    }
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if(textField == txtbookTitle)
        {
            let myColor = UIColor.black
            txtbookTitle.layer.borderColor = myColor.cgColor
            
            
            txtbookTitle.layer.borderWidth = 1.0
            
            if self.txtbookTitle.text?.count == 0
            {
                txtbookTitle.placeholder="Book Title"
                self.lblBookTitle.isHidden = true
            }
        }
            
        else  if(textField == txtAddQuestion)
        {
            let myColor = UIColor.black
            txtAddQuestion.layer.borderColor = myColor.cgColor
            
            txtAddQuestion.layer.borderWidth = 1.0
            
            if self.txtAddQuestion.text?.count == 0
            {
                txtAddQuestion.placeholder="Question"
                self.lblBookTitle.isHidden = true
            }
        }
            
            
        else if(textField == txtBookAuthor)
        {
            
            let myColor = UIColor.black
            txtBookAuthor.layer.borderColor = myColor.cgColor
            
            txtBookAuthor.layer.borderWidth = 1.0
            if self.txtBookAuthor.text?.count == 0
            {
                txtBookAuthor.placeholder="Book Author"
                self.lblAuthor.isHidden = true
            }
        }
        else if(textField == txtEnterQuestion)
        {
            
            let myColor = UIColor.black
            txtEnterQuestion.layer.borderColor = myColor.cgColor
            
            txtEnterQuestion.layer.borderWidth = 1.0
            if self.txtEnterQuestion.text?.count == 0
            {
                txtEnterQuestion.placeholder="Question"
                self.lblQuestion.isHidden = true
            }
        }
        
        
        
        return true
        
    }
    
    
    @IBAction func btnDocFileUpload(_ sender: Any) {
        
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        present(importMenu, animated: true)
        
    }
    
    
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        fileDocPath = myURL
        btnPdfLink.isHidden = false
        btnPdfLink.setTitle("https.docx", for: .normal)
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnRecodView(_ sender: Any) {
        
        let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kRecordingViewController) as! RecordingViewController
        
        
        BookdetailVC.modalPresentationStyle = .overFullScreen
        
        self.present(BookdetailVC, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnRecodingUpload(_ sender: Any) {
        
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        present(importMenu, animated: true)
        
        
        ////        flag = 2
        ////      galleryAudio()
        //       let mediaPickerController = MPMediaPickerController(mediaTypes: .anyAudio)
        //        mediaPickerController.delegate = self
        //        mediaPickerController.prompt = "Select Audio"
        //        present(mediaPickerController, animated: true, completion: nil)
        //
        //    }
        //    func mediaPicker(_ mediaPicker: MPMediaPickerController,
        //                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        //
        //      dismiss(animated: true) {
        //        let selectedSongs = mediaItemCollection.items
        //        guard let song = selectedSongs.first else { return }
        //
        //        let url = song.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
        //         let audioAsset = (url == nil) ? nil : AVAsset(url: url!)
        //        let title = (url == nil) ? "Asset Not Available" : "Asset Loaded"
        //        let message = (url == nil) ? "Audio Not Loaded" : "Audio Loaded"
        //
        //        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
        //        self.present(alert, animated: true, completion: nil)
        //      }
        //    }
        //
        //    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        //      dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnViedoUpload(_ sender: Any) {
        
        flag = 1
        
        CaputreImageClicked()
        
        
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
                    
                    
                    
                }
                else
                {
                    self.CategiesArr.removeAll()
                    
                    
                    for dataCategory in AllCategoryList! {
                        
                        self.CategiesArr.append(AllCategory(getAllCategory: dataCategory as! NSDictionary))
                        print(self.CategiesArr.count)
                        
                    }
                    
                    
                }
                
                
                
                
                
            }
        }, failure: { error in
            //self.HideLoader()
        })
    }
    
    
    
    //
    //  func AddNewBook_API_Method() {
    //
    //      let    userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
    //
    //
    //           let dictionary: NSDictionary = [
    //            "user_id"    : userId,
    //            "category_id" : category_Id,
    //            "book_title"  : txtbookTitle.text as Any,
    //            "book_description" : textViewBookDescription.text as Any,
    //            "author_name"  :  txtBookAuthor.text as Any,
    //            "pdf_url"      :  "",
    //            "video_url"   :   "",
    //            "audio_url"   :   "",
    //            "questiondata":   "",
    //            "isbn_number" :   "",
    //            "status" :   "1",
    //            "book_id" :  "",
    //            "cover_url" :""
    //
    //
    //            ]
    //    print (coverImage as Any)
    //
    //
    //    ServiceManager.POSTServerRequestWithImage(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", success: {response in
    //
    //
    //                         print("response-------",response!)
    //                         //self.HideLoader()
    //                         if response is NSDictionary {
    //                             let statusCode = response?["error"] as? Int
    //                             let message = response? ["message"] as? String
    //                             let AllCategoryList = response?["data"] as? NSDictionary
    //
    //                              print("response-------",response!)
    //
    //
    //                            if statusCode == 0
    //                            {
    //                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    //                                                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
    //
    //                                                      nextViewController.modalPresentationStyle = .overFullScreen
    //                                                      self.present(nextViewController, animated:true, completion:nil)
    //                            }
    //
    //                            else
    //                            {
    //
    //                            }
    //
    //
    //                        if AllCategoryList == nil || AllCategoryList?.count == 0 {
    //
    //
    //
    //                                      }
    //                                       else
    //                                      {
    //                                              self.CategiesArr.removeAll()
    //
    //
    //                                              for dataCategory in AllCategoryList! {
    //
    //                                                  self.CategiesArr.append(AllCategory(getAllCategory: dataCategory as! NSDictionary))
    //                                                  print(self.CategiesArr.count)
    //
    //                                              }
    //                                        self.category_id = self.CategiesArr[0].id!
    //
    //                                        self.BookByType_API_Method()
    //
    //
    //
    //
    //
    //                                          }
    //
    //
    //
    //
    //
    //                         }
    //                     }, failure: { error in
    //                         //self.HideLoader()
    //                     })
    //                 }
    
    @IBAction func btnPublish(_ sender: Any) {
        
        if self.txtbookTitle.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter Book Title")
            
        }
            
        else if self.textViewBookDescription.text?.count == 0 || textViewBookDescription.textColor == UIColor.lightGray
        {
            AlertVC(alertMsg:"Enter Your Book Description")
            
        }
        else if self.txtBookAuthor.text?.count == 0
        {
            AlertVC(alertMsg:"Enter Your Author Name")
            
        }
        else if self.txtRecommended.text?.count == 0
        {
            AlertVC(alertMsg:"Select Recommended Type")
            
        }
        else if coverImage == nil
        {
            self.AlertVC(alertMsg:"Please Upload Your cover Image")
            
        }
            
        else if filePathG == nil && fileDocPath == nil && fileAudioPath == nil  {
            
            ServerRestFlag = 1
        }
        else if !(filePathG == nil) && fileDocPath == nil && fileAudioPath == nil
        {
            ServerRestFlag = 2
        }
        else if filePathG == nil && !(fileDocPath == nil) && fileAudioPath == nil
        {
            ServerRestFlag = 3
        }
        else if filePathG == nil && fileDocPath == nil && !(fileAudioPath == nil)
        {
            ServerRestFlag = 4
        }
            
        else if !(filePathG == nil) && !(fileDocPath == nil) && fileAudioPath == nil
        {
            ServerRestFlag = 5
        }
        else if !(filePathG == nil) && fileDocPath == nil && !(fileAudioPath == nil)
        {
            ServerRestFlag = 6
        }
        else if filePathG == nil && !(fileDocPath == nil) && !(fileAudioPath == nil)
        {
            ServerRestFlag = 7
        }
            
        else if !(filePathG == nil) && !(fileDocPath == nil) && !(fileAudioPath == nil)
        {
            ServerRestFlag = 8
        }
        
        
        
        
        
        AddNewBook_API_Method(ServerFlag: ServerRestFlag)
        
        
    }
    
    
    
    
    
    @IBAction func btnSvaeForLater(_ sender: Any) {
        if self.txtbookTitle.text?.count == 0
        {
            AlertVC(alertMsg:"Please Enter Book Title")
            
        }
            
        else if self.textViewBookDescription.text?.count == 0 || textViewBookDescription.textColor == UIColor.lightGray
        {
            AlertVC(alertMsg:"Enter Your Book Description")
            
        }
        else if self.txtBookAuthor.text?.count == 0
        {
            AlertVC(alertMsg:"Enter Your Author Name")
            
        }
        else if self.txtRecommended.text?.count == 0
        {
            AlertVC(alertMsg:"Select Recommended Type")
            
        }
        else if coverImage == nil
        {
            self.AlertVC(alertMsg:"Please Upload Your cover Image")
            
        }
            
        else if filePathG == nil && fileDocPath == nil && fileAudioPath == nil  {
            
            ServerRestFlag = 1
        }
        else if !(filePathG == nil) && fileDocPath == nil && fileAudioPath == nil
        {
            ServerRestFlag = 2
        }
        else if filePathG == nil && !(fileDocPath == nil) && fileAudioPath == nil
        {
            ServerRestFlag = 3
        }
        else if filePathG == nil && fileDocPath == nil && !(fileAudioPath == nil)
        {
            ServerRestFlag = 4
        }
            
        else if !(filePathG == nil) && !(fileDocPath == nil) && fileAudioPath == nil
        {
            ServerRestFlag = 5
        }
        else if !(filePathG == nil) && fileDocPath == nil && !(fileAudioPath == nil)
        {
            ServerRestFlag = 6
        }
        else if filePathG == nil && !(fileDocPath == nil) && !(fileAudioPath == nil)
        {
            ServerRestFlag = 7
        }
            
        else if !(filePathG == nil) && !(fileDocPath == nil) && !(fileAudioPath == nil)
        {
            ServerRestFlag = 8
        }
        
        
        
        
        
        SaveImageLater_API_Method(ServerFlag: ServerRestFlag)
        
    }
    
    func AddNewBook_API_Method(ServerFlag : Int) {
        
        let    userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        print (listOfTextFields.count)
        for i in 0 ... listOfTextFields.count {
            
            if i < listOfTextFields.count && !(listOfTextFields[i].text!.isEmpty) {
                arrtextValue.append(String(listOfTextFields[i].text!))
            }
            
        }
        var jsonstr = String()
        if (arrtextValue.isEmpty)
        {
            jsonstr = ""
        }
        else
        {
            jsonstr = json(from: arrtextValue as Any)!
            print("\(String(describing: json(from:arrtextValue as Any)))")
            
        }
        
        
        
        
        
        let dictionary: NSDictionary = [
            "user_id"    : userId,
            "category_id" : category_Id,
            "book_title"  : txtbookTitle.text as Any,
            "book_description" : textViewBookDescription.text as Any,
            "author_name"  :  txtBookAuthor.text as Any,
            "audio_url"   :   "",
            "questiondata":   jsonstr,
            "isbn_number" :   "",
            "status" :   "1",
            "book_id" :  "",
            "cover_url" :""
        ]
        print (coverImage as Any)
        
        if ServerFlag == 1
        {
            ServiceManager.POSTServerRequestWithImage1(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        nextViewController.indexValue = "0"
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
        }
            
            
            
        else if ServerFlag == 2
        {
            ServiceManager.POSTServerRequestWithImage2(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", filePath : filePathG!, viedoPara: "video_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 3
        {
            ServiceManager.POSTServerRequestWithImage3(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", FileDocPath : fileDocPath!, docPara: "pdf_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
            
        else if ServerFlag == 4
        {
            ServiceManager.POSTServerRequestWithImage4(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", FileAudioPath : fileAudioPath!, AudioPara: "audio_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 5
        {
            
            
            ServiceManager.POSTServerRequestWithImage5(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image",filePath: filePathG!, viedoPara: "video_url", FileDocPath: fileDocPath!, docPara: "pdf_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 6
        {
            
            
            ServiceManager.POSTServerRequestWithImage6(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image",filePath: filePathG!, viedoPara: "video_url",FileAudioPath : fileAudioPath!, AudioPara: "audio_url" ,  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 7
        {
            
            
            ServiceManager.POSTServerRequestWithImage7(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image",FileDocPath : fileDocPath!, docPara: "pdf_url",FileAudioPath : fileAudioPath!, AudioPara: "audio_url" ,  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 8
        {
            
            
            ServiceManager.POSTServerRequestWithImage8(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", filePath: filePathG!, viedoPara: "video_url",FileDocPath : fileDocPath!, docPara: "pdf_url",FileAudioPath : fileAudioPath!, AudioPara: "audio_url" ,  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        
    }
    
    func SaveImageLater_API_Method(ServerFlag : Int) {
        let    userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        print (listOfTextFields.count)
        for i in 0 ... listOfTextFields.count {
            
            if i < listOfTextFields.count && !(listOfTextFields[i].text!.isEmpty) {
                arrtextValue.append(String(listOfTextFields[i].text!))
            }
            
        }
        var jsonstr = String()
        if (arrtextValue.isEmpty)
        {
            jsonstr = ""
        }
        else
        {
            jsonstr = json(from: arrtextValue as Any)!
            print("\(String(describing: json(from:arrtextValue as Any)))")
            
        }
        
        
        
        
        
        let dictionary: NSDictionary = [
            "user_id"    : userId,
            "category_id" : category_Id,
            "book_title"  : txtbookTitle.text as Any,
            "book_description" : textViewBookDescription.text as Any,
            "author_name"  :  txtBookAuthor.text as Any,
            "audio_url"   :   "",
            "questiondata":   jsonstr,
            "isbn_number" :   "",
            "status" :   "1",
            "book_id" :  "",
            "cover_url" :""
        ]
        print (coverImage as Any)
        
        if ServerFlag == 1
        {
            ServiceManager.POSTServerRequestWithImage1(kupdateBookByid, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        nextViewController.indexValue = "0"
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
        }
            
            
            
        else if ServerFlag == 2
        {
            ServiceManager.POSTServerRequestWithImage2(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", filePath : filePathG!, viedoPara: "video_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 3
        {
            ServiceManager.POSTServerRequestWithImage3(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", FileDocPath : fileDocPath!, docPara: "pdf_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
            
        else if ServerFlag == 4
        {
            ServiceManager.POSTServerRequestWithImage4(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", FileAudioPath : fileAudioPath!, AudioPara: "audio_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 5
        {
            
            
            ServiceManager.POSTServerRequestWithImage5(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image",filePath: filePathG!, viedoPara: "video_url", FileDocPath: fileDocPath!, docPara: "pdf_url",  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 6
        {
            
            
            ServiceManager.POSTServerRequestWithImage6(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image",filePath: filePathG!, viedoPara: "video_url",FileAudioPath : fileAudioPath!, AudioPara: "audio_url" ,  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 7
        {
            
            
            ServiceManager.POSTServerRequestWithImage7(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image",FileDocPath : fileDocPath!, docPara: "pdf_url",FileAudioPath : fileAudioPath!, AudioPara: "audio_url" ,  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        else if ServerFlag == 8
        {
            
            
            ServiceManager.POSTServerRequestWithImage8(kaddNewBook, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "thubm_image", filePath: filePathG!, viedoPara: "video_url",FileDocPath : fileDocPath!, docPara: "pdf_url",FileAudioPath : fileAudioPath!, AudioPara: "audio_url" ,  success: {response in
                
                
                print("response-------",response!)
                //self.HideLoader()
                if response is NSDictionary {
                    let statusCode = response?["error"] as? Int
                    let message = response? ["message"] as? String
                    let AllCategoryList = response?["data"] as? NSDictionary
                    
                    print("response-------",response!)
                    
                    
                    if statusCode == 0
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: kSWRevealViewController) as! SWRevealViewController
                        
                        nextViewController.modalPresentationStyle = .overFullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                        
                    else
                    {
                        
                    }
                    
                    
                    
                    
                }
            }, failure: { error in
                //self.HideLoader()
            })
            
        }
        
        
        
    }
    
    
    
    
    
    func CaputreImageClicked()
    {
        galleryVideo()
        
        //  openVideoGallery()
        
    }
    func galleryVideo()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            
            let videoPicker = UIImagePickerController()
            videoPicker.delegate = self
            videoPicker.sourceType = .photoLibrary
            videoPicker.mediaTypes = [kUTTypeMovie as String]
            self.present(videoPicker, animated: true, completion: nil)
        }
    }
    
    func galleryAudio()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            
            let videoPicker = UIImagePickerController()
            videoPicker.delegate = self
            videoPicker.sourceType = .photoLibrary
            videoPicker.mediaTypes = [kUTTypeMIDIAudio as String]
            self.present(videoPicker, animated: true, completion: nil)
            
            
            
            
        }
    }

    
    private func openImgPicker() {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }

    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})}
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue}
    
    
    @IBAction func btnUploadCoverImage(_ sender: Any) {
        
        flag = 0
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as! UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    
    func addQuestionTextField()
    {
        for i in 0 ... 10 {
            if(i == 0)
            {
                //   let imageView = UIImageView()
                
                
                let txtQuestion1 = UITextField()
                let lblQuestion1 = UILabel()
                let labQuestionCount1 = UILabel()
                txtQuestion1.tag = i+1
                labQuestionCount1.tag = i+1
                txtQuestion1.delegate = self
                
                txtQuestion1.layer.borderWidth = 1.0
                txtQuestion1.layer.cornerRadius = 5
                txtQuestion1.placeholder=" Question "
                lblQuestion1.isHidden = true
                let strQuestion = String(QuestionValue)
                labQuestionCount1.text = "Question " + strQuestion
                
                txtQuestion1.addPadding(.left(8))
                
                // 2.  To add right padding
                txtQuestion1.addPadding(.right(5))
                
                // 3. To add left & right padding both
                txtQuestion1.addPadding(.both(5))
                labQuestionCount1.frame = CGRect(x: 15, y: yOffset, width:100, height:20)
                txtQuestion1.frame = CGRect(x: 15, y: yOffset + buttonPadding, width:viewQuestion.frame.width - 30, height:40)
                
                yOffset = yOffset + buttonPadding + 15 + txtQuestion1.frame.size.height
                print (yOffset)
                
                QuestionValue = QuestionValue + 1
                // viewQuestion.addSubview (txtQuestion1)
                // viewQuestion.addSubview(labQuestionCount1)
                txtAddQuestion = txtQuestion1
                
                txtAddQuestion.delegate = self
                lblAddQuestion = labQuestionCount1
                print(labQuestionCount1.text)
                print(txtQuestion1.frame)
                txtQuestion1.isUserInteractionEnabled = true
                
                listOfTextFields.append(txtQuestion1)
                
                print(listOfTextFields.count)
                
            }}
        
        viewQuestion.backgroundColor = .white
        viewUploadMore.backgroundColor = .white
        viewQuestion.addSubview(lblAddQuestion)
        viewQuestion.addSubview(txtAddQuestion)
        txtAddQuestion.delegate = self
        //viewQuestion.contentSize = CGSize(width: 8, height: yOffset)
        
        viewQuestion.frame = CGRect(x: 6, y:viewQuestion.frame.origin.y, width:viewQuestion.frame.size.width, height:yOffset)
        viewUploadMore.frame = CGRect(x: 6, y:viewQuestion.frame.origin.y + viewQuestion.frame.height + 8, width:viewUploadMore.frame.size.width
            , height:viewUploadMore.frame.size.height)
        
        scrollView.contentSize = CGSize(width: 8, height:viewUploadMore.frame.origin.y + viewUploadMore.frame.size.height + 10)
        print(viewUploadMore.frame)
    }
    @IBAction func btnAddQuestion(_ sender: Any) {
        
        addQuestionTextField()
    }

    class TextField: UITextField {
        
        let padding = UIEdgeInsets(top:5, left: 5, bottom: 0, right: 5)
        
        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
            
            
        }
        
        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    }
    
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
        // print("\(json(from:array as Any))")
    }
    
    
    @IBAction func btnPublishBook(_ sender: Any) {
        
        
        //arrtextValue = [self.getInputsValue(listOfTextFields, seperatedby: ","]
        
        print (listOfTextFields.count)
        for i in 0 ... listOfTextFields.count {
            
            if i < listOfTextFields.count && !(listOfTextFields[i].text!.isEmpty) {
                arrtextValue.append(String(listOfTextFields[i].text!))
            }
            
        }
        print("\(String(describing: json(from:arrtextValue as Any)))")
        
    }
    func getInputsValue(_ inputs:[UITextField], seperatedby value: String) -> String {
        return inputs.sorted {$0.tag <  $1.tag}.map {$0.text}.compactMap({$0}).joined(separator: value)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        view.backgroundColor = UIColor.white
        viewimage.frame = CGRect(x:20, y:100 , width:view.frame.width-40, height:460)
        viewimage.layer.borderWidth = 5
        viewimage.layer.borderColor = UIColor.gray.cgColor
        self.imageUploadCoverImage.frame = CGRect(x:0, y:0 , width:view.frame.width-40, height:400)
        
        
        
        
        
        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
        
        let xPostion:CGFloat = 30
        let yPostion:CGFloat = imageUploadCoverImage.frame.height+imageUploadCoverImage.frame.origin.y+10
        let buttonWidth:CGFloat = imageUploadCoverImage.frame.width-60
        let buttonHeight:CGFloat = 40
        button.layer.cornerRadius = 15
        button.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        
        button.setTitle("OK", for: UIControl.State.normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(UploadBookViewController.buttonAction(_:)), for: .touchUpInside)
        
        self.viewimage.addSubview(button)
        self.view1.bringSubviewToFront(button)
        self.view1.bringSubviewToFront(viewimage)
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //  self.viewBanner.addSubview(btnCencel)
    
    
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

extension UploadBookViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if flag == 0
        {
            guard let selectedImage = info[.editedImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            imageData = selectedImage.pngData()!
            print (imageData)
            lblbookAssigmant.frame =  CGRect(x: lblbookAssigmant.frame.origin.x, y: 400, width: lblbookAssigmant.frame.width, height: lblbookAssigmant.frame.size.height)
            btnAdd.frame = CGRect(x: btnAdd.frame.origin.x, y: 400, width: btnAdd.frame.size.width, height: lblbookAssigmant.frame.size.height)
            imageUploadCoverImage.isHidden = false
            viewimage.isHidden = false
            // self.imageUploadCoverImage.image = selectedImage
            coverImage = selectedImage
            self.imageUploadCoverImage.image = coverImage
            print (imageUploadCoverImage.image as Any)
        }
            
        else if flag == 1
        {
            guard let mediaType = info[.mediaType] as? String,
                mediaType == kUTTypeMovie as String,
                let url = info[.mediaURL] as? URL
                else {
                    return
            }
            
            do {
                let asset = AVAsset(url: url) // video url from library
                let fileMgr = FileManager.default
                let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
                
                let filePath1 = dirPaths[0].appendingPathComponent("Video_\(datePresentString()).mp4") //create new data in file manage .mp4
                
                let asset2 = AVURLAsset.init(url: url)
                
       
                
                print(filePath1)
                
                btnUrl = filePath1
                
                filePathG = url
                
                btnImageLink.isHidden = false
                btnImageLink.setTitle("http.viedo", for: .normal)
                
                let bookmarkData = try url.bookmarkData()
                UserDefaults.standard.set(bookmarkData, forKey: "mediaURL")
                
                
            } catch {
                print("bookmarkData error: \(error)")
            }
        }
        
        func mediaURL() -> URL? {
            guard let urlData = UserDefaults.standard.data(forKey: "mediaURL") else {
                return nil
            }
            
            var staleData = false
            let mediaURL = try? URL(resolvingBookmarkData: urlData, options: .withoutUI, relativeTo: nil, bookmarkDataIsStale: &staleData)
            
            return staleData ? nil : mediaURL
        }
        
        
        if flag == 3
        {
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func datePresentString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        
        let iso8601String = dateFormatter.string(from: date as Date)
        
        return iso8601String
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
