//
//  ViewController.swift
//  UeBook
//
//  Created by Admin on 16/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import JitsiMeet
import AVFoundation
import MobileCoreServices
import Alamofire
import Popover
import AVKit
class ChatUserDetail: UIViewController {
     var player:AVPlayer?
     var playerItem:AVPlayerItem?
     var playButton:UIButton?

    
    var type = String()

    @IBOutlet weak var btnViedo: UIButton!
    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    fileprivate var jitsiMeetView: JitsiMeetView?
    // chating
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var inputViewContainerBottomConstraint: NSLayoutConstraint!
    
    var userId = String()
    
    @IBOutlet weak var txtMsgType: UITextField!
    var chatsArray: [Chat] = []
    var chatArr = [AllChatListClass]()
    var channelId = String()
    var sendTO = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
        Chat_API_Method()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.navigationItem.title = "Chat VC"
        self.assignDelegates()
        //  self.manageInputEventsForTheSubViews()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//    }
//
    
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
    
    
    func user_chat_API_Method()
    {
        
        let chatText = txtMsgType.text
        print(chatText as Any)
        
        
        let dictionary: NSDictionary = [
            "user_id" : userId,
            "channelId" : channelId,
            "sendTO"   :  sendTO,
            "tokenKey" :    "",
            "type"     :   "text",
            "message"   :  txtMsgType.text as Any
        ]
        ServiceManager.POSTServerRequest(String(kuser_chat), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
            //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["error"] as? String
                
                
                self.Chat_API_Method()
                
                
                
                
            }
        }, failure: { error in
            // self.HideLoader()
        })
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
        
        self.txtMsgType.delegate = self
    }
    
    
    
    
    @IBAction func btnSendMsg(_ sender: UIButton?) {
        
        guard let chatText = txtMsgType.text, chatText.count >= 1 else { return }
        
        
        txtMsgType.text = ""
        
        //  let chat = Chat.init(message:chatText)
        //
        //        let myDictName : [String:String] = ["message" : chatText]
        //        let value = myDictName["message"]
        
        user_chat_API_Method()
        //        let chat1 = AllChatListClass.init(getChatListData: value as! NSDictionary)
        //
        //                                                  self.chatArr.append(value)
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
        viedoCall(room: "room" ,boolean: false)
        
        
        
    }
    
    @IBAction func btnCall(_ sender: Any) {
        viedoCall(room: "room" ,boolean: true)
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
            
            // let chat = chatsArray[indexPath.item]
         //   let chating = chatArr[indexPath.item]
            if chatArr[indexPath.item].type == "video"
            {
             
                    
              
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
                            cell.sendImage.image = thumbImage
                            let btnPlay = UIButton()
                         //   btnPlay.frame = CGRectMake(center, 10.0, fieldWidth, 40.0)

                            btnPlay.frame = CGRect(x: cell.sendImage.frame.width/2-15, y: cell.sendImage.frame.height/2-15, width: 30, height: 30)
                            btnPlay.setImage(#imageLiteral(resourceName: "AudioPLAy5"), for:.normal)
                            
                            cell.sendImage.addSubview(btnPlay)
                            
                        }
                    } catch {
                        print(error.localizedDescription) //10
                        DispatchQueue.main.async {
                            cell.sendImage.image = #imageLiteral(resourceName: "noimage")
                            
                        }
                    }
                }
                
                
                


            }
            if  chatArr[indexPath.item].type == "text"
            {
                //                   cell.messageTextView.text = chat.text
                cell.messageTextView.text =  chatArr[indexPath.item].message
            }
            if  chatArr[indexPath.item].type == "audio"
            {
                
                let escapedString =  chatArr[indexPath.item].message
                let fullURL = kBaseUrl + escapedString!
                let url = URL(string:fullURL)!

                
                
             //   let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
                let playerItem:AVPlayerItem = AVPlayerItem(url: url)
                 player = AVPlayer(playerItem: playerItem)
                 
                 let playerLayer=AVPlayerLayer(player: player!)
                 playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
                self.view.layer.addSublayer(playerLayer)
             //   cell.textBubbleView.addsubp(playerLayer)

                 
                
//                playButton.frame = CGRect(x: cell.sendImage.frame.width/2-15, y: cell.sendImage.frame.height/2-15, width: 30, height: 30)
//                btnPlay.setImage(#imageLiteral(resourceName: "AudioPLAy5"), for:.normal)
//
                
                playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
                playButton!.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
                playButton!.setImage(#imageLiteral(resourceName: "play"), for:.normal)
                
//                 let xPostion:CGFloat = 50
//                 let yPostion:CGFloat = 100
//                 let buttonWidth:CGFloat = 150
//                 let buttonHeight:CGFloat = 45
//
//                 playButton!.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
//                 playButton!.backgroundColor = UIColor.lightGray
//                 playButton!.setTitle("Play", for: UIControl.State.normal)
//                 playButton!.tintColor = UIColor.black
                 //playButton!.addTarget(self, action: Selector("playButtonTapped:"), for: .touchUpInside)
                 playButton!.addTarget(self, action: #selector(ChatUserDetail.playButtonTapped(_:)), for: .touchUpInside)
                 
               //  self.view.addSubview(playButton!)
                cell.textBubbleView.addSubview(playButton!)
                 
                 // Add playback slider
                 
                 let playbackSlider = UISlider(frame:CGRect(x:50, y:20, width:100, height:30))
                 playbackSlider.minimumValue = 0
                 
                 
                 let duration : CMTime = playerItem.asset.duration
                 let seconds : Float64 = CMTimeGetSeconds(duration)
                 
                 playbackSlider.maximumValue = Float(seconds)
                 playbackSlider.isContinuous = true
                 playbackSlider.tintColor = UIColor.green
                 
                 playbackSlider.addTarget(self, action: #selector(ChatUserDetail.playbackSliderValueChanged(_:)), for: .valueChanged)
                // playbackSlider.addTarget(self, action: "playbackSliderValueChanged:", forControlEvents: .ValueChanged)
//                self.cell.te
//                self.cell.te.addSubview(playbackSlider)

                cell.textBubbleView.addSubview(playbackSlider)

                
                
                
                
            }
            if  chatArr[indexPath.item].type == "image"
            {
                let escapedString =  chatArr[indexPath.item].message
                let fullURL = kBaseUrl + escapedString!
                let url = URL(string:fullURL)!
                cell.sendImage.af_setImage(withURL:url , placeholderImage:#imageLiteral(resourceName: "noimage") )
                
                
            }
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            var estimatedFrame = NSString(string:  chatArr[indexPath.item].message!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            estimatedFrame.size.height += 18
            
            //                   let nameSize = NSString(string: chat.user_name).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
            //
            //                   let maxValue = max(estimatedFrame.width, nameSize.width)
            //                   estimatedFrame.size.width = maxValue
            
            let senderId =  chatArr[indexPath.item].sender
            let reciveId =  chatArr[indexPath.item].receiver
            
            if(senderId == userId)
            {
                
                
                if chatArr[indexPath.item].type == "image"
                {
                    cell.sendImage.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    cell.sendImage.layer.cornerRadius = 5
                    cell.sendImage.layer.borderWidth = 2
                    cell.sendImage.layer.borderColor = kChatTextBackColor.cgColor
                    cell.sendImage.shadowOpacity = 0.5
                    cell.textBubbleView.isHidden = true
                    

                }
                else if  chatArr[indexPath.item].type == "video"
                                   {
                                       cell.sendImage.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                                     cell.textBubbleView.isHidden = true
                                    
                                    cell.sendImage.layer.cornerRadius = 5
                                    cell.sendImage.layer.borderWidth = 2
                                    cell.sendImage.layer.borderColor = kChatTextBackColor.cgColor
                                    cell.sendImage.shadowOpacity = 0.5
                                 
                                //    cell.messageTextView.addSubview(cell.sendImage)
                                    
                                  //  let thumbnail = chating.message

//                                    cell.videoItem.url = URL(fileURLWithPath: thumbnail)
//                                        cell.videoItem?.image = thumbnail.square(to: 320)
//                                        cell.mediaStatus = MEDIASTATUS_SUCCEED
                                   }
                                       
                else if  chatArr[indexPath.item].type == "audio"
                {
                    cell.textBubbleView.isHidden = false
                    
                    cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: 12, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                    
                }
               
                    
               
              else  if  chatArr[indexPath.item].type == "text"
                {
                
                    
                    cell.messageTextView.isHidden = false
                    cell.textBubbleView.isHidden = false

                    cell.nameLabel.textAlignment = .right
                    cell.profileImageView.frame = CGRect(x: self.collectionView.bounds.width - 38, y: estimatedFrame.height, width: 30, height: 30)
                    cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 12, width: estimatedFrame.width + 16, height: 18)
                    cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: 12, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                    cell.bubbleImageView.image = ChatCell.blueBubbleImage
                    cell.bubbleImageView.tintColor = kChatTextBackColor
                    cell.messageTextView.textColor = UIColor.black
                    
                    //  cell.fetchAddImage(from: <#T##URL#>)
                    
                }
                
                
                
            } else {
                cell.nameLabel.textAlignment = .left
                cell.profileImageView.frame = CGRect(x: 8, y: estimatedFrame.height - 8, width: 30, height: 30)
                cell.nameLabel.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: 18)
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
                cell.bubbleImageView.image = ChatCell.grayBubbleImage
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
                
            }
        for view in cell.subviews {
              view.removeFromSuperview()
            }
            return cell
        }
        
        return ChatCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let chat = chatArr[indexPath.item]
        if let chatCell = cell as? ChatCell {
            //chatCell.profileImageURL = URL.init(string: chat.user_image_url)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
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
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let chat = chatArr [indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        var estimatedFrame = NSString(string: chat.message!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        estimatedFrame.size.height += 18
        
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 20)
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
        //btnSendByme(nil)
        
    }
}


