//
//  ChatCell.swift
//  UeBook
//
//  Created by Admin on 20/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AVFoundation

class ChatCell: LKBaseCollectionViewCell {
    
    static let identifier = String(describing: ChatCell.self)
    
    //    var chat: ChatModel? {
    //        didSet{
    //            guard let sender = chat else { return }
    //            self.setupTextViewLayout(chat: sender)
    //            if let url = URL.init(string: sender.user_image_url) {
    //                fetchProfileImage(from: url)
    //            }
    //            self.bubbleImageView.image = sender.is_sent_by_me ? grayBubbleImage : blueBubbleImage
    //            self.messageTextView.text = sender.text
    //        }
    //    }
    
    private var imageCache = NSCache<NSString, UIImage>()
    var profileImageURL: URL?
    {
        didSet{
            self.fetchProfileImage(from: profileImageURL!)
        }
    }
    
    //add image
    
    private var imageCacheAdd = NSCache<NSString, UIImage>()
       var sendImageUrl: URL?
       {
           didSet{
               self.fetchAddImage(from: sendImageUrl!)
           }
       }
    func fetchAddImage(from imageUrl: URL) {
         
         //If image is available in cache, use it
         if let img = self.imageCache.object(forKey: imageUrl.absoluteString as NSString) {
             DispatchQueue.main.async {
                 self.sendImage.image = img
                 
             }
             //Otherwise fetch from remote and cache it for futher use
         } else {
             
             let session = URLSession.init(configuration: .default)
             session.dataTask(with: imageUrl) { (data, response, error) in
                 DispatchQueue.main.async {
                     if let imgData = data {
                         if let img = UIImage(data: imgData) {
                             self.sendImage.image = img
                             self.imageCache.setObject(img, forKey: imageUrl.absoluteString as NSString)
                         }
                     }
                 }
                 }.resume()
         }
     }
    func thumbnail(path: String) -> UIImage {

            let asset = AVURLAsset(url: URL(fileURLWithPath: path), options: nil)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true

            var time: CMTime = asset.duration
            time.value = CMTimeValue(0)
            var actualTime = CMTimeMake(value: 0, timescale: 0)

            if let cgImage = try? generator.copyCGImage(at: time, actualTime: &actualTime) {
                return UIImage(cgImage: cgImage)
            }

            return UIImage()
        }

    func thumbnail2(url: URL) -> UIImage {
            let asset = AVAsset(url: url) //2

            //let asset = AVURLAsset(url: , options: nil)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true

            var time: CMTime = asset.duration
            time.value = CMTimeValue(0)
            var actualTime = CMTimeMake(value: 0, timescale: 0)

            if let cgImage = try? generator.copyCGImage(at: time, actualTime: &actualTime) {
                return UIImage(cgImage: cgImage)
            }

            return UIImage()
        }
    
        //---------------------------------------------------------------------------------------------------------------------------------------------
         func duration(path: String) -> Int {

            let asset = AVURLAsset(url: URL(fileURLWithPath: path), options: nil)
            return Int(round(CMTimeGetSeconds(asset.duration)))
        }
    

    
    func fetchProfileImage(from url: URL) {
        
        //If image is available in cache, use it
        if let img = self.imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.profileImageView.image = img
                
            }
            //Otherwise fetch from remote and cache it for futher use
        } else {
            
            let session = URLSession.init(configuration: .default)
            session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.profileImageView.image = img
                            self.imageCache.setObject(img, forKey: url.absoluteString as NSString)
                        }
                    }
                }
                }.resume()
        }
    }
    
    
    
    
    
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
      static let blueBubbletick = UIImage(named: "checknote")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    var textBubbleView: UIView = {
        let view = UIView()
        //        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.image = #imageLiteral(resourceName: "placeholder_user")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    var sendImage: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.image = #imageLiteral(resourceName: "noimage")
         imageView.layer.masksToBounds = true
         return imageView
     }()
     
    var bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatCell.blueBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()
    
    var nameLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(nameLabel)
        addSubview(messageTextView)
        addSubview(profileImageView)
        addSubview(sendImage)
        
        profileImageView.backgroundColor = UIColor.green
        
        textBubbleView.addSubview(bubbleImageView)
        addConstraintsWithVisualStrings(format: "H:|[v0]|", views: bubbleImageView)
        addConstraintsWithVisualStrings(format: "V:|[v0]|", views: bubbleImageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.profileImageView.image = nil
        self.sendImage.image = nil
        self.messageTextView.text = nil
    }
    
    //TODO : Use this for MVVM Architecture with two diff cells
    
    //    private func setupTextViewLayout(chat: ChatModel) {
    //
    //        let size = CGSize(width: 250, height: 1000)
    //        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    //        let estimatedFrame = NSString(string: chat.text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
    //
    //        if chat.is_sent_by_me {
    //
    //            addConstraintsWithVisualStrings(format: "H:|-8-[v0(30)]", views: profileImageView)
    //            addConstraintsWithVisualStrings(format: "V:[v0(30)]|", views: profileImageView)
    //
    //            self.messageTextView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
    //            self.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
    //            self.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
    //            self.messageTextView.textColor = UIColor.black
    //        } else {
    //
    //            addConstraintsWithVisualStrings(format: "H:[v0(30)]-8-|", views: profileImageView)
    //            addConstraintsWithVisualStrings(format: "V:[v0(30)]|", views: profileImageView)
    //
    //            self.messageTextView.frame = CGRect(x: self.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
    //            self.textBubbleView.frame = CGRect(x: self.bounds.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
    //            self.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
    //            self.messageTextView.textColor = UIColor.white
    //        }
    //        self.profileImageView.layoutIfNeeded()
    //    }
}
