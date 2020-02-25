//
//  ViewController.swift
//  UeBook
//
//  Created by Admin on 16/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import JitsiMeet
class ChatUserDetail: UIViewController {

    @IBOutlet weak var btnViedo: UIButton!
   fileprivate var pipViewCoordinator: PiPViewCoordinator?
   fileprivate var jitsiMeetView: JitsiMeetView?
    // chating
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var inputViewContainerBottomConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var txtMsgType: UITextField!
    var chatsArray: [Chat] = []
    var chatArr = [AllChatListClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
         Register_API_Method()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
                self.navigationItem.title = "Chat VC"
                self.assignDelegates()
              //  self.manageInputEventsForTheSubViews()
       
            }
                    
                    override func viewWillAppear(_ animated: Bool) {
                        super.viewWillAppear(animated)
                        
                        self.fetchChatData()
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
                    
            
            
           func Register_API_Method()
              {
                 

                  let dictionary: NSDictionary = [
                      "user_id" : "78",
                      "channelId" : "943602",
                      "sendTO"   :  "71"
                      
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
                                  
                                  self.chatArr.append(AllChatListClass(getChatListData: dataCategory as! NSDictionary))
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
                         "user_id" : "78",
                         "channelId" : "943602",
                         "sendTO"   :  "71",
                         "tokenKey" :    "",
                         "type"     :   "text",
                         "message"   :  txtMsgType.text
                    ]
                     ServiceManager.POSTServerRequest(String(kuser_chat), andParameters: dictionary as! [String : String], success: {response in
                         
                         print("response-------",response!)
                       //  self.HideLoader()
                         if response is NSDictionary {
                             let msg = response?["error"] as? String
                    
                            
                            self.Register_API_Method()
                             
                             
                             
                           
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
                   let chating = chatArr[indexPath.item]
                   
//                   cell.messageTextView.text = chat.text
                   cell.messageTextView.text = chating.message
//
//                   cell.nameLabel.text = chat.user_name
//                   cell.profileImageURL = URL.init(string: chat.user_image_url)!
//
                   let size = CGSize(width: 250, height: 1000)
                   let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                var estimatedFrame = NSString(string: chating.message!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
                   estimatedFrame.size.height += 18
                   
//                   let nameSize = NSString(string: chat.user_name).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
//
//                   let maxValue = max(estimatedFrame.width, nameSize.width)
//                   estimatedFrame.size.width = maxValue
                   
                let senderId = chating.sender
                let reciveId = chating.receiver
                
                if(senderId == "78")
                {
//                   if chat.is_sent_by_me {
                       
                    cell.nameLabel.textAlignment = .right
                                       cell.profileImageView.frame = CGRect(x: self.collectionView.bounds.width - 38, y: estimatedFrame.height - 8, width: 30, height: 30)
                                       cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 0, width: estimatedFrame.width + 16, height: 18)
                                       cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                                       cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                                       cell.bubbleImageView.image = ChatCell.blueBubbleImage
                                       cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                                       cell.messageTextView.textColor = UIColor.white
                    
                    
                    
                    
                      
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

   
