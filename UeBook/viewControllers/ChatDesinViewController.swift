//
//  ChatDesinViewController.swift
//  UeBook
//
//  Created by Admin on 21/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ChatDesinViewController: UIViewController{

    var chatsArray: [Chat] = []
    var ca:[Chat] = []
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtMsg: UITextField!
    @IBOutlet var inputViewContainerBottomConstraint: NSLayoutConstraint!

    var userId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
              Register_API_Method()
        userId = UserDefaults.standard.string(forKey: "Save_User_ID")!
                self.navigationItem.title = "Chat VC"
                self.assignDelegates()
                self.manageInputEventsForTheSubViews()
        
        
            }
            
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                
                self.fetchChatData()
            }
            
            private func fetchChatData() {
                
                let spinner = Spinner.init()
                spinner.show()
                
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
            "user_id" : userId
            
        ]
        ServiceManager.POSTServerRequest(String(kuser_list), andParameters: dictionary as! [String : String], success: {response in
            
            print("response-------",response!)
          //  self.HideLoader()
            if response is NSDictionary {
                let msg = response?["message"] as? String
                let statusCode = response?["error"] as? Int
               
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
                
                self.txtMsg.delegate = self
            }
               

    @IBAction func btnSend(_ sender: UIButton?) {
             guard let chatText = txtMsg.text, chatText.count >= 1 else { return }
                           txtMsg.text = ""
                           let chat = Chat.init(user_name: "vansh", user_image_url: "http://dnddemo.com//ebooks//api//v1//upload//books//book_1571738214.jpg", is_sent_by_me: true, text: chatText)
                           
                           self.chatsArray.append(chat)
                           self.collectionView.reloadData()
                           
                           let lastItem = self.chatsArray.count - 1
                           let indexPath = IndexPath(item: lastItem, section: 0)
                           //        self.chatCollView.insertItems(at: [indexPath])
                           self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                       }
    
    
    @IBAction func btnSendByme(_ sender:  UIButton?) {
        
        guard let chatText = txtMsg.text, chatText.count >= 1 else { return }
                                         txtMsg.text = ""
                                         let chat = Chat.init(user_name: "pooja", user_image_url: "http://dnddemo.com//ebooks//api//v1//upload//books//book_1571738214.jpg", is_sent_by_me: false, text: chatText)
                                         
                                         self.chatsArray.append(chat)
                                         self.collectionView.reloadData()
                                         
                                         let lastItem = self.chatsArray.count - 1
                                         let indexPath = IndexPath(item: lastItem, section: 0)
                                         //        self.chatCollView.insertItems(at: [indexPath])
                                         self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    
    
    
    
              }

        extension ChatDesinViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
            
            func numberOfSections(in collectionView: UICollectionView) -> Int {
                
                return 1
            }
            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
                return chatsArray.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell {
                    
                    let chat = chatsArray[indexPath.item]
                    
                    cell.messageTextView.text = chat.text
                    cell.nameLabel.text = chat.user_name
                    cell.profileImageURL = URL.init(string: chat.user_image_url)!
                    
                    let size = CGSize(width: 250, height: 1000)
                    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                    var estimatedFrame = NSString(string: chat.text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
                    estimatedFrame.size.height += 18
                    
                    let nameSize = NSString(string: chat.user_name).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
                    
                    let maxValue = max(estimatedFrame.width, nameSize.width)
                    estimatedFrame.size.width = maxValue
                    
                    
                    if chat.is_sent_by_me {
                        
                        cell.nameLabel.textAlignment = .left
                        cell.profileImageView.frame = CGRect(x: 8, y: estimatedFrame.height - 8, width: 30, height: 30)
                        cell.nameLabel.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: 18)
                        cell.messageTextView.frame = CGRect(x: 48 + 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                        cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
                        cell.bubbleImageView.image = ChatCell.grayBubbleImage
                        cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                        cell.messageTextView.textColor = UIColor.black
                    } else {
                        
                        cell.nameLabel.textAlignment = .right
                        cell.profileImageView.frame = CGRect(x: self.collectionView.bounds.width - 38, y: estimatedFrame.height - 8, width: 30, height: 30)
                        cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 0, width: estimatedFrame.width + 16, height: 18)
                        cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                        cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                        cell.bubbleImageView.image = ChatCell.blueBubbleImage
                        cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                        cell.messageTextView.textColor = UIColor.white
                    }
                    
                    return cell
                }
                
                return ChatCell()
            }
            
            func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                
                let chat = chatsArray[indexPath.item]
                if let chatCell = cell as? ChatCell {
                    chatCell.profileImageURL = URL.init(string: chat.user_image_url)!
                }
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            }
            
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
                self.view.endEditing(true)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
                let chat = chatsArray[indexPath.item]
                let size = CGSize(width: 250, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                var estimatedFrame = NSString(string: chat.text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
                estimatedFrame.size.height += 18
                
                return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 20)
            }
            
        }

        extension ChatDesinViewController: UITextFieldDelegate {
            
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
                if let txt = textField.text, txt.count >= 1 {
                    textField.resignFirstResponder()
                    return true
                }
                return false
            }
            
            func textFieldDidEndEditing(_ textField: UITextField) {
                
                textField.resignFirstResponder()
                btnSend(nil)
                btnSendByme(nil)
                
            }
        }

    
    

           
          
