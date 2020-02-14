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


class UploadBookViewController: UIViewController ,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate , AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    //viedo upload
    var imagePickerController = UIImagePickerController()
    var videoURL : NSURL?
    var audioRecorder:AVAudioRecorder!

    @IBOutlet weak var imageViedo: UIImageView!
    //
    @IBOutlet weak var viewRoundedView: RoundedView!
    
    var value:Int = 0
     
     var strRecommmended = ["Recommmended","New Books", " Sport", "Music","Story","Dev test"] //multi-season
     
     var activeDataArray = [String]()
    
    let buttonPadding:CGFloat = 30
    var yOffset:CGFloat = 10
    var  QuestionValue:Int = 1
     var txtAddQuestion = UITextField()
    var lblAddQuestion = UILabel()
    var arrtextValue = [String]()
     
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return activeDataArray.count
     }
     
     func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return activeDataArray[row]
     }
     
     func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        
         
             txtRecommended.text = activeDataArray[row]
             self.view.endEditing(true)
         
      
     }
    
    
     

     let thePicker = UIPickerView()
    
    
    
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

        
        
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        
    
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
               
//               txtEnterQuestion.placeholder="Question"
//               lblQuestion.isHidden = true
               
               textViewBookDescription.text = "Book Description"
               textViewBookDescription.textColor = UIColor.lightGray
               lblDescription.isHidden = true
               
               
               
               
//               
//               btnUploadCoverImage.layer.cornerRadius = 5
//               btnUploadCoverImage.layer.borderWidth = 1.0
//               btnUploadCoverImage.layer.borderColor = UIColor.black.cgColor
//               
//               btnPublish.layer.cornerRadius = 5
//              // btnPublish.layer.borderWidth = 1.0

//               btnSaveForLater.layer.cornerRadius = 5
//              // btnSaveForLater.layer.borderWidth = 1.0

               
        // Do any additional setup after loading the view.
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
    }
    
    @IBAction func btnRecodingUpload(_ sender: Any) {
    }
    @IBAction func btnViedoUpload(_ sender: Any) {
        
        
   
      CaputreImageClicked()
        

    }
    
    func viedoupload()
    {
        let viedoView = UIView()
        viedoView.frame = CGRect(x: 15, y:viewUploadMore.frame.origin.y + 100 + 20 , width:50, height:50)
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 15, y: viewUploadMore.frame.origin.y  + viewRoundedView.frame.origin.y + viewRoundedView.frame.size.height + 20 , width:100, height:100)
         //scrollView.layer.addSublayer(playerLayer)
        viedoView.layer.addSublayer(playerLayer)
        viewUploadMore.addSubview(viedoView)
       self.view.layer.addSublayer(playerLayer)
        player.play()
        
        

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
//              func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//          // 1
//          //guard
//            let mediaType = info[UIImagePickerController.InfoKey.mediaURL] as? URL
//                let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
////            else {
////                mediaType == (kUTTypeMovie as String),
////              return
////          }
//    ////
//          // 2
//          dismiss(animated: true) {
//            //3
//            let player = AVPlayer(url: url!)
//            let vcPlayer = AVPlayerViewController()
//            vcPlayer.player = player
//            self.present(vcPlayer, animated: true, completion: nil)
//          }
//        }
//
    
 private func openImgPicker() {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
//  func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any])
//    {
//        
//        
//        let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
//         print(videoURL!)
//         self.dismiss(animated: true, completion: nil)
//    }
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})}

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue}
//    func openVideoGallery()
//    {
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        //imagePicker.sourceType = .savedPhotosAlbum
//        //imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
//        imagePicker.mediaTypes = ["public.movie"]
//
//       // imagePicker.allowsEditing = false
//        present(imagePicker, animated: true, completion: nil)
//    }

    @IBAction func btnUploadCoverImage(_ sender: Any) {
    }
    @IBAction func btnSaveForlater(_ sender: Any) {
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
     
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
               guard let mediaType = info[.mediaType] as? String,
                   mediaType == kUTTypeMovie as String,
                   let url = info[.mediaURL] as? URL else {
                   return
               }

               do {
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
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
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
    
   
