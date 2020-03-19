//
//  ViewController.swift
//  UeBook
//
//  Created by Admin on 16/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Photos

import JitsiMeet
import AVFoundation
import MobileCoreServices
import Alamofire
import Popover
import AVKit
import PDFKit
import Foundation
import ISEmojiView

class ChatUserDetail: UIViewController ,UITextViewDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate , EmojiViewDelegate{
    
    
    
    @IBOutlet weak var userProfile: UIImageView!
     var isEmoji = true
    var fileDocPath : URL?
    var filePathG  :URL?
    var coverImage :UIImage!
    var TypeVlaue = String()
    @IBOutlet weak var btnName: UIButton!
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    var flag = 0
    
    // -----------------------//
     var myView = UIView()
    var uploadImageView = UIImageView()
    var LblUploadImage = UILabel()
    var btnCancel = UIButton()
    var btnSend   = UIButton()
    var transparentView = UIView()
    //----------------------//

    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var textEnterMSg: UITextView!
    var type = String()
    
    @IBOutlet weak var btnEmoji: UIButton!
    @IBOutlet weak var btnViedo: UIButton!
    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    fileprivate var jitsiMeetView: JitsiMeetView?
    // chating
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var inputViewContainerBottomConstraint: NSLayoutConstraint!
    
    var userId = String()
    var userProfileURL = String()
    var chatsArray: [Chat] = []
    var chatArr = [AllChatListClass]()
    var channelId = String()
    @IBOutlet weak var texEmoji: UITextField!
    var sendTO = String()
    var ChatContactName = String()
    var messType  = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let url = URL(string:userProfileURL)!
    
        
        transparentView = UIView(frame: CGRect(x: 0, y: 0 , width:view.frame.width, height: view.frame.height))
        transparentView.backgroundColor = ktransparentColor
        myView = UIView(frame: CGRect(x: view.frame.width/2 - 150, y: view.frame.height/2 - 200, width:300, height: 400))
        myView.backgroundColor = .white
        myView.layer.borderWidth = 2
        myView.layer.borderColor = UIColor.gray.cgColor
        uploadImageView = UIImageView(frame: CGRect(x: 10, y: 40 , width:280, height: myView.frame.height - 40 - 40 - 10))
        uploadImageView.sizeToFit()
        LblUploadImage = UILabel(frame: CGRect(x: 0, y: 0, width:300, height: 30))
        LblUploadImage.backgroundColor = kAppColor
        LblUploadImage.textAlignment = .center
        LblUploadImage.textColor = .white
        LblUploadImage.text = "Upload Image"
        
        btnCancel = UIButton(frame: CGRect(x: 0, y: myView.frame.height-40, width: myView.frame.width/2, height: 40))
        btnCancel.backgroundColor = .lightGray
        btnCancel.addTarget(self, action: #selector(btnCancel(_:)), for: .touchUpInside)
      
        let keyboardSettings = KeyboardSettings(bottomType: .categories)
              let emojiView = EmojiView(keyboardSettings: keyboardSettings)
              emojiView.translatesAutoresizingMaskIntoConstraints = false
              emojiView.delegate = self
              
           texEmoji.inputView = emojiView
        
        
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(.white, for: .normal)
        
        btnSend = UIButton(frame: CGRect(x: btnCancel.frame.width + btnCancel.frame.origin.x, y: myView.frame.height-40, width: btnCancel.frame.width, height: 40))
        btnSend.backgroundColor = kAppColor
        btnSend.setTitle("Send", for: .normal)
        btnSend.setTitleColor(.white, for: .normal)
        btnSend.addTarget(self, action: #selector(btnSendImage(_:)), for: .touchUpInside)
        myView.addSubview(btnCancel)
        myView.addSubview(btnSend)
        myView.addSubview(uploadImageView)
        myView.addSubview(LblUploadImage)
        transparentView.addSubview(myView)
        self.view.addSubview(transparentView)
        transparentView.isHidden = true
        
        
        userProfile.layer.cornerRadius = 20
                  DispatchQueue.main.async {
                    self.userProfile.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
        }
                          let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                            userProfile.addGestureRecognizer(tap)
                            self.userProfile.isUserInteractionEnabled = true
                      
                      
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        btnName.setTitle(ChatContactName, for: .normal)
        Chat_API_Method()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.navigationItem.title = "Chat VC"
        self.assignDelegates()
        //  self.manageInputEventsForTheSubViews()
        
        
    }
    
  
    // callback when tap a emoji on keyboard
    func emojiViewDidSelectEmoji(_ emoji: String, emojiView: EmojiView) {
        textEnterMSg.insertText(emoji)
        
    }

    // callback when tap change keyboard button on keyboard
    func emojiViewDidPressChangeKeyboardButton(_ emojiView: EmojiView) {
        textEnterMSg.inputView = nil
        textEnterMSg.keyboardType = .default
        textEnterMSg.reloadInputViews()
    }
        
    // callback when tap delete button on keyboard
    func emojiViewDidPressDeleteBackwardButton(_ emojiView: EmojiView) {
        textEnterMSg.deleteBackward()
    }

    // callback when tap dismiss button on keyboard
    func emojiViewDidPressDismissKeyboardButton(_ emojiView: EmojiView) {
        textEnterMSg.resignFirstResponder()
    }
  @objc func btnCancel(_ sender: UIButton){
    
    //dismiss(animated: true, completion: nil)
    transparentView.isHidden = true
    }
    @objc func btnSendImage(_ sender: UIButton){
     transparentView.isHidden = true
        print ("you r there")
        let strmsg  = textEnterMSg.text
        user_chat_API_Method(Msg: strmsg!)
        
        guard let chatText = textEnterMSg.text, chatText.count >= 1 else { return }
        
        
        
        
        self.collectionView.reloadData()
        
        let lastItem = self.chatArr.count - 1
        let indexPath = IndexPath(item: lastItem, section: 0)
        //        self.chatCollView.insertItems(at: [indexPath])
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier:kImageZoomInZoomOutViewController ) as! ImageZoomInZoomOutViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        let url = URL(string:userProfileURL)!
        nextViewController.imageurl = url
        nextViewController.name = ChatContactName
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func btnName(_ sender: Any) {
        //imageAlertView()
    }
    
    
    
    @IBAction func ChooseSendData(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Option", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in

            self.openCamera()

        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction(title: "Video Library", style: .default, handler: { _ in
            self.opengalleryVideo()
        }))
        alert.addAction(UIAlertAction(title: "Audio", style: .default, handler: { _ in
            self.opengalleryVideo()
        }))
        alert.addAction(UIAlertAction(title: "Docment", style: .default, handler: { _ in
            self.openDocmentFile()
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
        flag = 0
        messType = "image"
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
        flag = 0
        messType = "image"
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    func opengalleryVideo()
    {
        flag = 1
        messType = "video"
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            
            let videoPicker = UIImagePickerController()
            videoPicker.delegate = self
            videoPicker.sourceType = .photoLibrary
            videoPicker.mediaTypes = [kUTTypeMovie as String]
            self.present(videoPicker, animated: true, completion: nil)
        }
    }
    
    func openDocmentFile()
    {
        messType = "docfile"
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
        thumbnailFromPdf(withUrl: myURL, pageNumber: 1)
        
    }
    func thumbnailFromPdf(withUrl url:URL, pageNumber:Int, width: CGFloat = 240) -> UIImage? {
        guard let pdf = CGPDFDocument(url as CFURL),
            let page = pdf.page(at: pageNumber)
            else {
                return nil
        }
        transparentView.isHidden = false
        var pageRect = page.getBoxRect(.mediaBox)
        let pdfScale = width / pageRect.size.width
        pageRect.size = CGSize(width: pageRect.size.width*pdfScale, height: pageRect.size.height*pdfScale)
        pageRect.origin = .zero

        UIGraphicsBeginImageContext(pageRect.size)
        let context = UIGraphicsGetCurrentContext()!

        // White BG
        context.setFillColor(UIColor.white.cgColor)
        context.fill(pageRect)
        context.saveGState()

        // Next 3 lines makes the rotations so that the page look in the right direction
        context.translateBy(x: 0.0, y: pageRect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.concatenate(page.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))

        context.drawPDFPage(page)
        context.restoreGState()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        LblUploadImage.text = "SEND DOUCMENT FILE"
        uploadImageView.image = image
        return image
    }
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchChatData()
        
    }
    //not use
    func AudioPlayer()
    {
        let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        
        playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        playButton!.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        playButton!.backgroundColor = UIColor.lightGray
        playButton!.setTitle("Play", for: UIControl.State.normal)
        playButton!.tintColor = UIColor.black
        //playButton!.addTarget(self, action: Selector("playButtonTapped:"), for: .touchUpInside)
        playButton!.addTarget(self, action: #selector(ChatUserDetail.playButtonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(playButton!)
        
        
        // Add playback slider
        
        let playbackSlider = UISlider(frame:CGRect(x:10, y:300, width:300, height:20))
        playbackSlider.minimumValue = 0
        
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        playbackSlider.tintColor = UIColor.green
        
        playbackSlider.addTarget(self, action: #selector(ChatUserDetail.playbackSliderValueChanged(_:)), for: .valueChanged)
        // playbackSlider.addTarget(self, action: "playbackSliderValueChanged:", forControlEvents: .ValueChanged)
        self.view.addSubview(playbackSlider)
        
    }
    
    
    
    func  imageAlertView()
        
    {
        let alert = UIAlertController(title:"Zip Viewer ", message: "Thanks for using Speedy unZip Viewer ", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Zip Viewer", style: .default, handler: nil)
        
        // image set in alret view inside
        // size to fit in view
        var image = UIImage(named: "4-home-1")
        
        image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left:  -40, bottom: 0, right: 50))
        
        
        saveAction.setValue(image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
        alert.addAction(saveAction)
        
        
        alert.addAction(UIAlertAction(title: "Rate", style: UIAlertAction.Style.default, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Write a Review", style: UIAlertAction.Style.default, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertAction.Style.default, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func fetchChatData() {
        
        let spinner = Spinner.init()
        // spinner.show()
        
        if let url = Bundle.main.url(forResource: "chat", withExtension: "json") {
            
            DispatchQueue.main.async {
                spinner.hide()
            }
            do {
                
                let data = try Data.init(contentsOf: url)
                let decoder = JSONDecoder.init()
                self.chatsArray = try decoder.decode([Chat].self, from: data)
                self.collectionView.reloadData()
                
            } catch let err {
                print(err.localizedDescription)
            }
            
        }
    }
    
    
    func Chat_API_Method()
    {
        
        
        let dictionary: NSDictionary = [
            "user_id" : userId,
            "channelId" : channelId,
            "sendTO"   :  sendTO
            
        ]
        
        ServiceManager.POSTServerRequest(String(kuser_chat), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
            //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["message"] as? String
                let userList = response?["chat_list"] as? NSArray
                let statusCode = response?["error"] as? Int
                
                
                
                
                if userList == nil || userList?.count == 0 {
                    
                    //self.noDataFoundLbl.isHidden = false
                    self.collectionView.isHidden = true
                }
                else {
                    self.chatArr.removeAll()
                    self.collectionView.isHidden = false
                    
                    for dataCategory in userList! {
                        
                        self.chatArr.append(AllChatListClass(getChatListClass: dataCategory as! NSDictionary))
                    }
                    self.collectionView.reloadData()
                    let lastItem = self.chatArr.count - 1
                    let indexPath = IndexPath(item: lastItem, section: 0)
                    //        self.chatCollView.insertItems(at: [indexPath])
                    self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
                    
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
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func user_chat_API_Method(Msg:String)
    {
        
        // let chatText = txtMsgType.text
        // print(chatText as Any)
        
        
        
        
        if messType == "image"
        {
            let dictionary: NSDictionary = [
                "user_id" : userId,
                "channelId" : channelId,
                "sendTO"   :  sendTO,
                "tokenKey" :    "",
                "type"     :   "image",
                "message"   :  Msg
            ]
            ServiceManager.POSTServerRequestWithImage(kuser_chat, andParameters: dictionary as! [String : String], andImage:coverImage , imagePara: "image_file", success: {response in
                
                print("response-------",response!)
                //  self.HideLoader()
                if response is NSDictionary {
                    let error = response?["error"] as? Int
                    if error == 0
                    {
                        self.textEnterMSg.text = ""
                        self.Chat_API_Method()
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
            }, failure: { error in
                // self.HideLoader()
            })
        }
        
        if messType == "video"
        {
            let dictionary: NSDictionary = [
                "user_id" : userId,
                "channelId" : channelId,
                "sendTO"   :  sendTO,
                "tokenKey" :    "",
                "type"     :   "video",
                "message"   :  Msg
            ]
            ServiceManager.POSTServerRequestWithVideo(kuser_chat, andParameters:dictionary as! [String : String] , filePath: filePathG!, viedoPara: "video_file", success: {response in
                
                print("response-------",response!)
                //  self.HideLoader()
                if response is NSDictionary {
                    let error = response?["error"] as? Int
                    if error == 0
                    {
                        self.Chat_API_Method()
                        self.textEnterMSg.text = ""
                    }
                    
                    
                    
                    
                    
                    
                    
                }
            }, failure: { error in
                // self.HideLoader()
            })
        }
        if messType == "docfile"
        {
            let dictionary: NSDictionary = [
                "user_id" : userId,
                "channelId" : channelId,
                "sendTO"   :  sendTO,
                "tokenKey" :    "",
                "type"     :   "docfile",
                "message"   :  Msg
            ]
            ServiceManager.POSTServerRequestWithDocment(kuser_chat, andParameters:dictionary as! [String : String] , FileDocPath: fileDocPath!, docPara: "pdf_file", success: {response in
                
                print("response-------",response!)
                //  self.HideLoader()
                if response is NSDictionary {
                    let error = response?["error"] as? Int
                    if error == 0
                    {
                        self.Chat_API_Method()
                        self.textEnterMSg.text = ""
                    }
                    
                    
                    
                    
                    
                    
                    
                }
            }, failure: { error in
                // self.HideLoader()
            })
        }
            
        else
        {
            let dictionary: NSDictionary = [
                "user_id" : userId,
                "channelId" : channelId,
                "sendTO"   :  sendTO,
                "tokenKey" :    "",
                "type"     :   "text",
                "message"   :  Msg
            ]
            ServiceManager.POSTServerRequest(String(kuser_chat), andParameters: dictionary as! [String : String], success: {response in
                
                print("response-------",response!)
                //  self.HideLoader()
                if response is NSDictionary {
                    let error = response?["error"] as? Int
                    if error == 0
                    {
                        self.Chat_API_Method()
                        self.textEnterMSg.text = ""
                    }
                    
                    
                    
                    
                    
                    
                    
                }
            }, failure: { error in
                // self.HideLoader()
            })
        }
    }
    private func manageInputEventsForTheSubViews() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardFrameChangeNotfHandler(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            inputViewContainerBottomConstraint.constant = isKeyboardShowing ? keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    let lastItem = self.chatsArray.count - 1
                    let indexPath = IndexPath(item: lastItem, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
    
    private func assignDelegates() {
        
        self.collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.textEnterMSg.delegate = self
    }
    
    
    
    
    @IBAction func btnSendMsg(_ sender: UIButton?) {
        transparentView.isHidden = true
        
        print ("you r there")
        let strmsg  = textEnterMSg.text
        user_chat_API_Method(Msg: strmsg!)
        
        guard let chatText = textEnterMSg.text, chatText.count >= 1 else { return }
        
        
        
        
        self.collectionView.reloadData()
        
        let lastItem = self.chatArr.count - 1
        let indexPath = IndexPath(item: lastItem, section: 0)
        //        self.chatCollView.insertItems(at: [indexPath])
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        
    }
    
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        pipViewCoordinator?.resetBounds(bounds: rect)
    }
    @IBAction func btnViedo(_ sender: Any) {
        viedoCall(room: channelId ,boolean: false)
        
        
        
    }
    
    @IBAction func btnCall(_ sender: Any) {
        viedoCall(room: channelId ,boolean: true)
    }
    func viedoCall(room:String, boolean: Bool)
    {
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.welcomePageEnabled = true
            builder.room = room
            builder.audioOnly=boolean
        }
        jitsiMeetView.join(options)
        
        // Enable jitsimeet view to be a view that can be displayed
        // on top of all the things, and let the coordinator to manage
        // the view state and interactions
        pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
        pipViewCoordinator?.configureAsStickyView(withParentView: view)
        
        // animate in
        jitsiMeetView.alpha = 0
        pipViewCoordinator?.show()
    }
    
    fileprivate func cleanUp() {
        jitsiMeetView?.removeFromSuperview()
        jitsiMeetView = nil
        pipViewCoordinator = nil
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

// for viedo call
extension ChatUserDetail: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.hide() { _ in
                self.cleanUp()
            }
        }
    }
    
    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}

extension ChatUserDetail: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chatArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell {
            
            for subview in cell.textBubbleView.subviews {


                                subview.removeFromSuperview()

                           }
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            var estimatedFrame = NSString(string:  chatArr[indexPath.item].message!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            estimatedFrame.size.height += 18
            
            let senderId =  chatArr[indexPath.item].sender
            let reciveId =  chatArr[indexPath.item].receiver
            cell.layer.anchorPointZ = CGFloat(indexPath.row)
            
            if(senderId == userId)
            {
               
//                                                  cell.nameLabel.textAlignment = .right
//                                                  cell.profileImageView.frame = CGRect(x: self.collectionView.bounds.width - 38, y: estimatedFrame.height, width: 30, height: 30)
//                                                  cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 12, width: estimatedFrame.width + 16, height: 18)
//
                                                  cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: 12, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
//                                                  cell.bubbleImageView.image = ChatCell.blueBubbleImage
//                                                  cell.bubbleImageView.tintColor = kChatTextBackColor
                
                
                if chatArr[indexPath.item].type == "image"
                {
                   
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFill
                    let escapedString =  chatArr[indexPath.item].message
                    let fullURL = kBaseUrl + escapedString!
                    let url = URL(string:fullURL)!
                    imageView.frame = CGRect(x: 0, y: 0, width:cell.textBubbleView.frame.width, height: cell.textBubbleView.frame.height)
                    imageView.layer.cornerRadius = 10
                    imageView.layer.masksToBounds = true
                    imageView.layer.borderWidth = 2
                    imageView.layer.borderColor = kAppColor.cgColor
                    imageView.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )
                    cell.textBubbleView.addSubview(imageView)
                    
                    
                }
                if  chatArr[indexPath.item].type == "video"
                {
                    
                    let imageviewVideo = UIImageView()
                    imageviewVideo.contentMode = .scaleAspectFill

                    let escapedString =  chatArr[indexPath.item].message
                    let fullURL = kBaseUrl + escapedString!
                    let url = URL(string:fullURL)!
                    
                    
                    DispatchQueue.global().async { //1
                        let asset = AVAsset(url: url) //2
                        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
                        avAssetImageGenerator.appliesPreferredTrackTransform = true //4
                        let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
                        do {
                            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                            let thumbImage = UIImage(cgImage: cgThumbImage) //7
                            DispatchQueue.main.async { //8
                                
                                
                                imageviewVideo.frame = CGRect(x: 0, y: 0, width:cell.textBubbleView.frame.width, height: cell.textBubbleView.frame.height)
                                imageviewVideo.layer.cornerRadius = 10
                                imageviewVideo.layer.masksToBounds = true
                                imageviewVideo.image = thumbImage
                                imageviewVideo.layer.borderWidth = 2
                                imageviewVideo.layer.borderColor = kAppColor.cgColor
                                // self.imageView.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                                let btnPlay = UIButton()
                                
                                btnPlay.frame = CGRect(x: cell.textBubbleView.frame.width/2-15, y: cell.textBubbleView.frame.height/2-15, width: 30, height: 30)
                                btnPlay.setImage(#imageLiteral(resourceName: "AudioPLAy5"), for:.normal)
                                imageviewVideo.addSubview(btnPlay)
                                cell.textBubbleView.addSubview(imageviewVideo)
                                
                            }
                        } catch {
                            print(error.localizedDescription) //10
                            DispatchQueue.main.async {
                                //cell.sendImage.image = #imageLiteral(resourceName: "noimage")
                                
                            }
                        }
                        
                        
                    }
                    
                    
                    
                }
                    
                    
                    
                else if chatArr[indexPath.item].type == "docfile"{
                    
                    
                    
                    let docView = UIView()
                    let docImage = UIButton()
                    let lblDoc   = UILabel()
                    docView.frame = CGRect(x: 0, y: 0, width:cell.textBubbleView.frame.width, height: cell.textBubbleView.frame.height)
                    docView.backgroundColor = kChatTextBackColor
                    docImage.frame = CGRect(x: docView.frame.width/2 - 30, y: docView.frame.height/2 - 20, width: 40,height: 40)
                    docImage.setImage(#imageLiteral(resourceName: "filechat"), for:.normal)
                    lblDoc.frame = CGRect(x: docImage.frame.width + docImage.frame.origin.x + 10, y: docView.frame.height/2 - 20, width: 40,height:40)
                    lblDoc.text =  "File"
                    lblDoc.font = UIFont.boldSystemFont(ofSize: 20)

                    lblDoc.textColor = UIColor.black
                    docView.addSubview(docImage)
                    docView.addSubview(lblDoc)
                    
                    cell.textBubbleView.addSubview(docView)
                    
                }
                    
                else if  chatArr[indexPath.item].type == "audio"
                {
                    cell.textBubbleView.isHidden = false
                    
                    cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: 12, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                    
                }
                    
                    
                    
                else  if  chatArr[indexPath.item].type == "text"
                {
                    
//                     cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: 12, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                    cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    cell.messageTextView.text =  chatArr[indexPath.item].message
                    cell.messageTextView.textColor = UIColor.black
                    
                    
//                    cell.nameLabel.textAlignment = .right
//                    cell.profileImageView.frame = CGRect(x: self.collectionView.bounds.width - 38, y: estimatedFrame.height, width: 30, height: 30)
//                    cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 12, width: estimatedFrame.width + 16, height: 18)

//                    cell.messageTextView.backgroundColor = kChatTextBackColor
//                    cell.bubbleImageView.image = ChatCell.blueBubbleImage
//                    cell.bubbleImageView.tintColor = kChatTextBackColor

                    cell.textBubbleView.backgroundColor = kChatTextBackColor
                   
                   

                }
                
            } else {
           
                
          //      cell.nameLabel.textAlignment = .left
             //   cell.profileImageView.frame = CGRect(x: 8, y: estimatedFrame.height - 8, width: 30, height: 30)
             //   cell.nameLabel.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: 18)
                cell.textBubbleView.frame = CGRect(x: 48 - 10, y: 10, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
//                cell.bubbleImageView.image = ChatCell.grayBubbleImage
//                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
         
                if chatArr[indexPath.item].type == "image"
                {
                   
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFill

                    let escapedString =  chatArr[indexPath.item].message
                    let fullURL = kBaseUrl + escapedString!
                    let url = URL(string:fullURL)!
                    imageView.frame = CGRect(x: 0, y: 0, width:cell.textBubbleView.frame.width, height: cell.textBubbleView.frame.height)
                    imageView.layer.cornerRadius = 10
                    imageView.layer.masksToBounds = true
                    imageView.layer.borderWidth = 2
                    imageView.layer.borderColor = kAppColor.cgColor
                    imageView.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )
                    cell.textBubbleView.addSubview(imageView)
                    
                    
                }
                if  chatArr[indexPath.item].type == "video"
                {
                  

                    let imageviewVideo = UIImageView()
                    imageviewVideo.contentMode = .scaleAspectFill
  
                    let escapedString =  chatArr[indexPath.item].message
                    let fullURL = kBaseUrl + escapedString!
                    let url = URL(string:fullURL)!
                    
                    
                    DispatchQueue.global().async { //1
                        let asset = AVAsset(url: url) //2
                        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
                        avAssetImageGenerator.appliesPreferredTrackTransform = true //4
                        let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
                        do {
                            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                            let thumbImage = UIImage(cgImage: cgThumbImage)//7

                            DispatchQueue.main.async { //8
                                
                                
                                imageviewVideo.frame = CGRect(x: 0, y: 0, width:cell.textBubbleView.frame.width, height: cell.textBubbleView.frame.height)
                                imageviewVideo.layer.cornerRadius = 10
                                imageviewVideo.layer.masksToBounds = true
                                imageviewVideo.image = thumbImage
                                imageviewVideo.layer.borderWidth = 2
                                imageviewVideo.layer.borderColor = kAppColor.cgColor
                                // self.imageView.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
                                let btnPlay = UIButton()
                                
                                btnPlay.frame = CGRect(x: cell.textBubbleView.frame.width/2-15, y: cell.textBubbleView.frame.height/2-15, width: 30, height: 30)
                                btnPlay.setImage(#imageLiteral(resourceName: "AudioPLAy5"), for:.normal)
                                imageviewVideo.addSubview(btnPlay)
                                cell.textBubbleView.addSubview(imageviewVideo)
                                
                            }
                        } catch {
                            print(error.localizedDescription) //10
                            DispatchQueue.main.async {
                                //cell.sendImage.image = #imageLiteral(resourceName: "noimage")
                                
                            }
                        }
                        
                        
                    }
                    
                    
                    
                }
                    
                    
                    
                else if chatArr[indexPath.item].type == "docfile"{
                    
                    let docView = UIView()
                    let docImage = UIButton()
                    let lblDoc   = UILabel()
                    docView.frame = CGRect(x: 0, y: 0, width:cell.textBubbleView.frame.width, height: cell.textBubbleView.frame.height)
                    docView.backgroundColor = kChatTextBackColor
                    docImage.frame = CGRect(x: docView.frame.width/2 - 30, y: docView.frame.height/2 - 20, width: 40,height: 40)
                    docImage.setImage(#imageLiteral(resourceName: "filechat"), for:.normal)
                    lblDoc.frame = CGRect(x: docImage.frame.width + docImage.frame.origin.x + 10, y: docView.frame.height/2 - 20, width: 40,height:40)
                    lblDoc.text =  "File"
                    lblDoc.font = UIFont.boldSystemFont(ofSize: 20)

                    lblDoc.textColor = UIColor.black
                    docView.addSubview(docImage)
                    docView.addSubview(lblDoc)
                    
                    cell.textBubbleView.addSubview(docView)
                    
                }
                    
                else if  chatArr[indexPath.item].type == "audio"
                {
                    cell.textBubbleView.isHidden = false
                    
                    cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: 12, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                    
                }
                    
                    
                    
                else  if  chatArr[indexPath.item].type == "text"
                {

//                cell.nameLabel.textAlignment = .left
//                cell.profileImageView.frame = CGRect(x: 8, y: estimatedFrame.height - 8, width: 30, height: 30)
//                cell.nameLabel.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: 18)
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
              cell.bubbleImageView.image = ChatCell.grayBubbleImage
//                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
                cell.messageTextView.text =  chatArr[indexPath.item].message
                    cell.textBubbleView.backgroundColor = kwhiteSmoke
            }
            }
            return cell
            
        }
        
        return ChatCell()
    }
    
    
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let chat = chatArr[indexPath.item]
        if let chatCell = cell as? ChatCell {
            //chatCell.profileImageURL = URL.init(string: chat.user_image_url)!
        }
    }
    
    
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
        
        
        //textEnterMSg.frame.origin.y =
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 320, height: 520);
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if chatArr[indexPath.row].type == "video"
        {
            let escapedString = chatArr[indexPath.row].message
            let fullURL = kBaseUrl + escapedString!
            let ViedoUrl = URL(string:fullURL)!
            
            let player = AVPlayer(url:ViedoUrl)  // video path coming from above function
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            
        }
        if chatArr[indexPath.row].type == "image"
        {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier:kImageZoomInZoomOutViewController ) as! ImageZoomInZoomOutViewController
            nextViewController.modalPresentationStyle = .overFullScreen
            let escapedString = chatArr[indexPath.row].message
            let fullURL = kBaseUrl + escapedString!
            let ImageURl = URL(string:fullURL)!
           
            nextViewController.imageurl = ImageURl
            nextViewController.name = ChatContactName
            self.present(nextViewController, animated:true, completion:nil)
            
            
        }
        
        
        
        if chatArr[indexPath.row].type == "docfile"
        {
            let escapedString = chatArr[indexPath.row].message
            let base = "dnddemo.com/ebooks/api/v1/"
                     let fullURL = base + escapedString!
                     //let DocumentUrl = URL(string:fullURL)!
                   
                     
     
                                               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                               let nextViewController = storyBoard.instantiateViewController(withIdentifier:kWebDocmentViewController ) as! WebDocmentViewController
                                               nextViewController.modalPresentationStyle = .overFullScreen
                                               nextViewController.DocumentBookUrl = fullURL
                                             
                                               self.present(nextViewController, animated:true, completion:nil)
            
        }
        self.view.endEditing(true)
    }
    @objc func handleUploadTap(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        print("image tapped")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let chat = chatArr [indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        var estimatedFrame = NSString(string: chat.message!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        estimatedFrame.size.height += 30
        
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 25)
    }
    
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    
    @objc func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Pause", for: UIControl.State.normal)
            playButton!.setImage(#imageLiteral(resourceName: "play"), for:.normal)
            
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setImage(#imageLiteral(resourceName: "pause"), for:.normal)
            //playButton!.setTitle("Play", for: UIControl.State.normal)
        }
    }
    
    
}

extension ChatUserDetail: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let txt = textField.text, txt.count >= 1 {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
           btnSendMsg(nil)
        messType = "text"
        //btnSendByme(nil)
        
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
    
    
}

extension ChatUserDetail:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if flag == 0
        {
            guard let selectedImage = info[.editedImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            
            coverImage = selectedImage
            print (coverImage as Any)
            transparentView.isHidden = false
           // collectionView.backgroundColor  = ktransparentColor
            uploadImageView.image = coverImage
            self.LblUploadImage.text = "SEND IMAGE"

            // imageAlertView()
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
                self.LblUploadImage.text = "SEND VIDEO"
                transparentView.isHidden = false
               
                let player = AVPlayer(url: url)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.myView.bounds
                uploadImageView.isHidden = true
                self.myView.layer.addSublayer(playerLayer)
                player.play()
                
                filePathG = url
                
                

                
//                             DispatchQueue.global().async { //1
//                                 let asset = AVAsset(url: url) //2
//                                 let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
//                                 avAssetImageGenerator.appliesPreferredTrackTransform = true //4
//                                 let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
//                                 do {
//                                     let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
//                                     let thumbImage = UIImage(cgImage: cgThumbImage) //7
//                                     DispatchQueue.main.async { //8
//
//
//
//                                        self.uploadImageView.image = thumbImage
//                                         // self.imageView.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "user_default") )
//                                         let btnPlay = UIButton()
//
//                                        btnPlay.frame = CGRect(x: self.uploadImageView.frame.width/2-15, y: self.uploadImageView.frame.height/2-15, width: 30, height: 30)
//                                         btnPlay.setImage(#imageLiteral(resourceName: "AudioPLAy5"), for:.normal)
//                                        self.uploadImageView.addSubview(btnPlay)
//
//                                     }
//                                 } catch {
//                                     print(error.localizedDescription) //10
//                                     DispatchQueue.main.async {
//                                         //cell.sendImage.image = #imageLiteral(resourceName: "noimage")
//
//                                     }
//                                 }
//
//
//
//
//            }
                
                
                
                
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
