//
//  Repository.swift
//  UeBook
//
//  Created by Admin on 21/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class AllUserContactListClass{
    
    var userId: String?
    var name: String?
    var email: String?
    var phone: String?
    var channelId: String?
    var url: String?
    var publisher_type: String?
    var device_token: String?
    var device_type: String?
    var avatar: String?
    
    init(getAllUserListData: NSDictionary) {
        
        self.userId          = getAllUserListData["userId"] as? String
        self.name            = getAllUserListData["name"] as? String
        self.email           = getAllUserListData["email"] as? String
        self.phone           = getAllUserListData["phone"] as? String
        self.channelId       = getAllUserListData["channelId"] as? String
        self.url             = getAllUserListData["url"] as? String
        self.publisher_type  = getAllUserListData["publisher_type"] as? String
        self.device_token    = getAllUserListData["device_token"] as? String
        self.device_type     = getAllUserListData["device_type"] as? String
        self.avatar          = getAllUserListData["avatar"] as? String

        
       
    }
}

class AllGroupListClass {
    var userId: String?
    var name: String?
    var email: String?
    var phone: String?
    var channelId: String?
    var url: String?
    var publisher_type: String?
    var device_token: String?
    var device_type: String?
    var avatar: String?
    
    init(getAllGroupListClass: NSDictionary) {
        
        self.userId          = getAllGroupListClass["userId"] as? String
        self.name            = getAllGroupListClass["name"] as? String
        self.email           = getAllGroupListClass["email"] as? String
        self.phone           = getAllGroupListClass["phone"] as? String
        self.channelId       = getAllGroupListClass["channelId"] as? String
        self.url             = getAllGroupListClass["url"] as? String
        self.publisher_type  = getAllGroupListClass["publisher_type"] as? String
        self.device_token    = getAllGroupListClass["device_token"] as? String
        self.device_type     = getAllGroupListClass["device_type"] as? String
        self.avatar          = getAllGroupListClass["avatar"] as? String

        
       
    }
}





class AllpopularBook {
    var id: String?
    var book_title: String?
    var thubm_image: String?
    var author_name: String?
    var category_id: String?
    var book_description: String?
    var mostView: String?
    var rating: String?
    var category_name: String?
    

    init(getAllpopularBookData: NSDictionary) {
       
        self.id                    =   getAllpopularBookData["id"] as? String
        self.book_title            =   getAllpopularBookData["book_title"] as? String
        self.thubm_image           =   getAllpopularBookData["thubm_image"] as? String
        self.author_name           =   getAllpopularBookData["author_name"] as? String
        self.category_id           =   getAllpopularBookData["category_id"] as? String
        self.book_description      =   getAllpopularBookData["book_description"] as? String
        self.mostView              =   getAllpopularBookData["mostView"] as? String
        self.rating                =   getAllpopularBookData["rating"] as? String
        self.category_name         =   getAllpopularBookData["category_name"] as? String
        
        
       
    }
}





class AllBookDescription : NSObject {
    var id: String?
    var user_id: String?
    var category_id: String?
    var category_name: String?
    var book_title: String?
    var book_description: String?
    var book_slug: String?
    var thubm_image: String?
    var author_name: String?
    var book_image: String?
    
    var video_url: String?
       var audio_url: String?
       var pdf_url: String?
       var isbn_number: String?
    
    
    var mostView: String?
    var status: String?
    var created_at: String?
    var updated_at: String?
    
    
    var userId: String?
    var profile_pic: String?
    var user_name: String?

    init(getBookDescriptionData: NSDictionary) {
       
        self.id                    =   getBookDescriptionData["id"] as? String
        self.user_id               =   getBookDescriptionData["user_id"] as? String
        self.category_id           =   getBookDescriptionData["category_id"] as? String
        self.category_name         =   getBookDescriptionData["category_name"] as? String
        self.book_title            =   getBookDescriptionData["book_title"] as? String
        self.book_description      =   getBookDescriptionData["book_description"] as? String
        self.book_slug             =   getBookDescriptionData["book_slug"] as? String
        self.thubm_image           =   getBookDescriptionData["thubm_image"] as? String
        
        
        
        self.author_name           =   getBookDescriptionData["author_name"] as? String
        self.book_image            =   getBookDescriptionData["book_image"] as? String
        self.video_url             =   getBookDescriptionData["video_url"] as? String
        
        
        
        self.audio_url             =   getBookDescriptionData["audio_url"] as? String
        self.pdf_url               =   getBookDescriptionData["pdf_url"] as? String
        self.isbn_number           =   getBookDescriptionData["isbn_number"] as? String
        self.mostView              =   getBookDescriptionData["mostView"] as? String
        self.status                =   getBookDescriptionData["status"] as? String
        self.created_at            =   getBookDescriptionData["created_at"] as? String
        self.updated_at            =   getBookDescriptionData["updated_at"] as? String
        self.userId                =   getBookDescriptionData["userId"] as? String
        self.profile_pic           =   getBookDescriptionData["profile_pic"] as? String
        self.user_name             =   getBookDescriptionData["user_name"] as? String
        
       
    }
}


class AllPendingBookByBookID : NSObject {
   

       var audio_url: String?
       var author_name: String?
       var book_description: String?
       var book_image: String?
       var book_title: String?
       var category_id: String?
       var id: String?
       var pdf_url: String?
       var thubm_image: String?
       var user_id: String?
        var video_url: String?


    init(getAllPendingBook: NSDictionary) {
       
   
        self.audio_url             =   getAllPendingBook["audio_url"] as? String
        self.author_name           =   getAllPendingBook["author_name"] as? String
        self.book_description      =   getAllPendingBook["book_description"] as? String
        self.book_image            =   getAllPendingBook["book_image"] as? String
        self.book_title            =   getAllPendingBook["book_title"] as? String
        self.category_id           =   getAllPendingBook["category_id"] as? String
        self.id                    =   getAllPendingBook["id"] as? String
        self.pdf_url               =   getAllPendingBook["pdf_url"] as? String
        self.thubm_image           =   getAllPendingBook["thubm_image"] as? String
        self.user_id               =   getAllPendingBook["user_id"] as? String
        self.video_url             =   getAllPendingBook["video_url"] as? String

       
    }
}




class Allreview {
    var ReviewId: String?
    var comment: String?
    var rating: String?
    var created_at: String?
    var user_name: String?
    var url: String?
    

init(getReviewListData: NSDictionary) {
        
        self.ReviewId                = getReviewListData["ReviewId"] as? String
        self.comment                 = getReviewListData["comment"] as? String
        self.rating                  = getReviewListData["rating"] as? String
        self.created_at              = getReviewListData["created_at"] as? String
        self.user_name               = getReviewListData["user_name"] as? String
        self.url                     = getReviewListData["url"] as? String
        
        
       
    }
}

class AllAssignmentList{
    var id: String?
    var book_id: String?
    var question: String?
   
    
    
   
init(getAssignmentListData: NSDictionary) {
        
        self.id                = getAssignmentListData["id"] as? String
        self.book_id                 = getAssignmentListData["book_id"] as? String
        self.question                  = getAssignmentListData["question"] as? String
        
        
        
       
    }
}
class AllFaceBookList{
    var email: String?
    var first_name: String?
    var id: String?
   var last_name: String?
   var name: String?
 
    
    
   
init(getFaceBookData: NSDictionary) {
        
        self.email                       = getFaceBookData["email"] as? String
        self.first_name                  = getFaceBookData["first_name"] as? String
        self.id                          = getFaceBookData["id"] as? String
        self.last_name                   = getFaceBookData["last_name"] as? String
         self.name                   = getFaceBookData["name"] as? String
    
        
        
       
    }
}

class AllbookMarkByUser{
    var id: String?
    var book_title: String?
    var thubm_image: String?
    var author_name: String?
    var book_description: String?
    var user_id: String?
    var bookmark_id: String?
    var bm_status: String?
    var rating: String?
    
    
    
    
    
    init(getAllbookMarkByUser: NSDictionary) {
        
        self.id                       = getAllbookMarkByUser["id"] as? String
        self.book_title               = getAllbookMarkByUser["book_title"] as? String
        self.thubm_image              = getAllbookMarkByUser["thubm_image"] as? String
        self.author_name              = getAllbookMarkByUser["author_name"] as? String
        self.book_description         = getAllbookMarkByUser["book_description"] as? String
        
        self.user_id                  = getAllbookMarkByUser["user_id"] as? String
        self.bookmark_id              = getAllbookMarkByUser["bookmark_id"] as? String
        self.bm_status                = getAllbookMarkByUser["bm_status"] as? String
        self.rating                   = getAllbookMarkByUser["rating"] as? String
        
        
    }
}

class AllNotebyUser{
    var id: String?
    var title: String?
    var description: String?
    var created_at: String?
 
    
    
   
init(getAllNotebyUser: NSDictionary) {
        
        self.id                           = getAllNotebyUser["id"] as? String
        self.title                        = getAllNotebyUser["title"] as? String
        self.description                  = getAllNotebyUser["description"] as? String
        self.created_at                   = getAllNotebyUser["created_at"] as? String
    
        
        
       
    }
}

class AllUserDetails : NSObject {
    var id: String?
    var user_name: String?
    var url: String?
    var email: String?
    var about_me: String?
    var publisher_type: String?
    var device_token: String?
    var device_type: String?
   
   

    init(getUserDetails: NSDictionary) {
       
        self.id                      =   getUserDetails["id"] as? String
        self.user_name               =   getUserDetails["user_name"] as? String
        self.url                     =   getUserDetails["url"] as? String
        self.email                   =   getUserDetails["email"] as? String
        self.about_me                =   getUserDetails["about_me"] as? String
        self.publisher_type          =   getUserDetails["publisher_type"] as? String
        self.device_token            =   getUserDetails["device_token"] as? String
        self.device_type             =   getUserDetails["device_type"] as? String
        
        }
}






class  AllUserBooklist{
    var id: String?
    var book_title: String?
    var thubm_image: String?
    var author_name: String?
 
    var book_description: String?
    var rating: String?
 
   
init(getAllUserBooklist: NSDictionary) {
        
        self.id                           = getAllUserBooklist["id"] as? String
        self.book_title                   = getAllUserBooklist["book_title"] as? String
        self.thubm_image                  = getAllUserBooklist["thubm_image"] as? String
        self.author_name                  = getAllUserBooklist["author_name"] as? String
        self.book_description             = getAllUserBooklist["book_description"] as? String
        self.rating                       = getAllUserBooklist["rating"] as? String
    
       
    }
}


class  AllUserPendingBooklist{
    var id: String?
    var book_title: String?
    var thubm_image: String?
    var author_name: String?
 
    var book_description: String?
 
   
init(getAllUserPendingBooklist: NSDictionary) {
        
        self.id                           = getAllUserPendingBooklist["id"] as? String
        self.book_title                   = getAllUserPendingBooklist["book_title"] as? String
        self.thubm_image                  = getAllUserPendingBooklist["thubm_image"] as? String
        self.author_name                  = getAllUserPendingBooklist["author_name"] as? String
        self.book_description             = getAllUserPendingBooklist["book_description"] as? String
    
       
    }
}



class  AllCategory{
    var id: String?
    var category_name: String?
    var slug_url: String?
    var description: String?
    
    var status: String?
    var thum_image: String?
    var created: String?
    var created_at: String?
    var updated_at: String?
   
init(getAllCategory: NSDictionary) {
        
    self.id                           = getAllCategory["id"] as? String
    self.category_name                = getAllCategory["category_name"] as? String
    self.slug_url                     = getAllCategory["slug_url"] as? String
    self.description                  = getAllCategory["description"] as? String
    self.status                       = getAllCategory["status"] as? String
    self.thum_image                   = getAllCategory["thum_image"] as? String
    
    self.created                      = getAllCategory["created"] as? String
    self.created_at                   = getAllCategory["created_at"] as? String
    self.updated_at                   = getAllCategory["updated_at"] as? String
    
    }
}

class  AllBooksByTypes{
    var id: String?
    var book_title: String?
    var thubm_image: String?
   
    var author_name: String?
    var book_description: String?
    var rating: String?
    
   
init(getBooksByTypes: NSDictionary) {
        
    self.id                           = getBooksByTypes["id"] as? String
    self.book_title                   = getBooksByTypes["book_title"] as? String
    self.thubm_image                  = getBooksByTypes["thubm_image"] as? String
    self.author_name                  = getBooksByTypes["author_name"] as? String
    self.book_description             = getBooksByTypes["book_description"] as? String
    self.rating                       = getBooksByTypes["rating"] as? String
    
    }
}



class  AllgetUserInfo : NSObject{
    var id: String?
    var register_id: String?
    var full_name: String?
    var user_name: String?
 
    var url: String?
    var email: String?
    
    
      var gender: String?
       var phone_no: String?
       var country: String?
    
       var password: String?
       var date_edited: String?
       
 
    var status: String?
         var message_status: String?
         var publisher_type: String?
      
         var about_me: String?
         var device_token: String?
    var device_type: String?
         var address: String?
         var global_posting: String?
   
init(getAllUserInfo: NSDictionary) {
    
    self.id                            = getAllUserInfo["id"] as? String
    self.register_id                   = getAllUserInfo["register_id"] as? String
    self.full_name                     = getAllUserInfo["full_name"] as? String
    self.user_name                     = getAllUserInfo["user_name"] as? String
    self.url                           = getAllUserInfo["url"] as? String
    self.email                         = getAllUserInfo["email"] as? String
    
    self.gender                           = getAllUserInfo["gender"] as? String
    self.phone_no                   = getAllUserInfo["phone_no"] as? String
    self.country                  = getAllUserInfo["country"] as? String
    self.password                  = getAllUserInfo["password"] as? String
    self.date_edited             = getAllUserInfo["date_edited"] as? String
    self.status                       = getAllUserInfo["status"] as? String
    
    
    self.message_status                           = getAllUserInfo["message_status"] as? String
    self.publisher_type                   = getAllUserInfo["publisher_type"] as? String
    self.about_me                  = getAllUserInfo["about_me"] as? String
    self.device_token                  = getAllUserInfo["device_token"] as? String
    self.device_type             = getAllUserInfo["device_type"] as? String
    self.address                       = getAllUserInfo["address"] as? String
    self.global_posting                       = getAllUserInfo["global_posting"] as? String
    }
}


class  AllFollowStatus{
    var id: String?
    var user_id: String?
    var status: String?
   
    var request_date: String?
    var url: String?
    var user_name: String?
    
   var publisher_type: String?
   
init(getFollowStatus: NSDictionary) {
        
    self.id                            = getFollowStatus["id"] as? String
    self.user_id                       = getFollowStatus["user_id"] as? String
    self.status                        = getFollowStatus["status"] as? String
    self.request_date                  = getFollowStatus["request_date"] as? String
    self.url                           = getFollowStatus["url"] as? String
    self.user_name                     = getFollowStatus["user_name"] as? String
     self.publisher_type               = getFollowStatus["publisher_type"] as? String
    }
}

struct SendAnswerData {
      var books_id: String
      var assId: String
      var answer   : String
       var answered_by : String
  
   init(_ dictionary: [String: Any]) {
      self.books_id = dictionary["books_id"] as? String ?? "NA"
      self.assId = dictionary["assignment_id"] as? String ?? "NA"
    
      self.answer = dictionary["Answer"] as? String ?? "NA"
      self.answered_by = dictionary["answered_by"] as? String ?? "NA"
    
    }
}


class  AllGroupList{
    var id: String?
    var name: String?
    var group_image: String?
    
    var userid: String?
    var groupuserid: String?
    var status: String?
    
    var created_at: String?
    var updated_at: String?
    var type: String?
    
    var removegroupuserid: String?
    var messagetype: String?
    var message: String?
    
    var unreadmessage: String?
    var groupid: String?
    var message_date: String?
        
init(getAllGroupList: NSDictionary) {
    
    self.id                            = getAllGroupList["id"] as? String
    self.name                       = getAllGroupList["name"] as? String
    self.group_image                        = getAllGroupList["group_image"] as? String
    
    self.userid                  = getAllGroupList["userid"] as? String
    self.groupuserid                           = getAllGroupList["groupuserid"] as? String
    self.status                     = getAllGroupList["status"] as? String
    
    self.created_at                  = getAllGroupList["created_at"] as? String
    self.updated_at                           = getAllGroupList["updated_at"] as? String
    self.type                     = getAllGroupList["type"] as? String
    
    self.removegroupuserid                  = getAllGroupList["removegroupuserid"] as? String
    self.messagetype                           = getAllGroupList["messagetype"] as? String
    self.message                           = getAllGroupList["message"] as? String
    
    self.unreadmessage                  = getAllGroupList["unreadmessage"] as? String
    self.groupid                           = getAllGroupList["groupid"] as? String
    self.message_date                           = getAllGroupList["message_date"] as? String
    }
}


class AllChatListClass {

    var channelId : String!
    var chid : String!
    var created : String!
    var deletedMsgFromUser : String!
    var id : String!
    var isActive : String!
    var isDeleted : String!
    var isReciver : String!
    var messCount : MessCount!
    var message : String!
    var modified : String!
    var readMsg : String!
    var recDetail : RecDetail!
    var receiver : String!
    var sendDetail : SendDetail!
    var sender : String!
    var type : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(getChatListClass: NSDictionary){
        channelId = getChatListClass["channel_id"] as? String
        chid = getChatListClass["chid"] as? String
        created = getChatListClass["created"] as? String
        deletedMsgFromUser = getChatListClass["deleted_msg_from_user"] as? String
        id = getChatListClass["id"] as? String
        isActive = getChatListClass["is_active"] as? String
        isDeleted = getChatListClass["is_deleted"] as? String
        isReciver = getChatListClass["is_reciver"] as? String
        message = getChatListClass["message"] as? String
        modified = getChatListClass["modified"] as? String
        readMsg = getChatListClass["read_msg"] as? String
        receiver = getChatListClass["receiver"] as? String
        sender = getChatListClass["sender"] as? String
        type = getChatListClass["type"] as? String
        if let messCountData = getChatListClass["mess_count"] as? [String:Any]{
            messCount = MessCount(fromDictionary: messCountData)
        }
        if let recDetailData = getChatListClass["rec_detail"] as? [String:Any]{
            recDetail = RecDetail(fromDictionary: recDetailData)
        }
        if let sendDetailData = getChatListClass["send_detail"] as? [String:Any]{
            sendDetail = SendDetail(fromDictionary: sendDetailData)
        }
    }
}
class SendDetail {
 
    

        var aboutMe : String!
        var deviceToken : String!
        var deviceType : String!
        var email : String!
        var id : String!
        var publisherType : String!
        var url : String!
        var userName : String!


        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            aboutMe = dictionary["about_me"] as? String
            deviceToken = dictionary["device_token"] as? String
            deviceType = dictionary["device_type"] as? String
            email = dictionary["email"] as? String
            id = dictionary["id"] as? String
            publisherType = dictionary["publisher_type"] as? String
            url = dictionary["url"] as? String
            userName = dictionary["user_name"] as? String
        }
}
class RecDetail {

    var aboutMe : String!
    var deviceToken : String!
    var deviceType : String!
    var email : String!
    var id : String!
    var publisherType : String!
    var url : String!
    var userName : String!

    init(fromDictionary dictionary: [String:Any]){
        aboutMe = dictionary["about_me"] as? String
        deviceToken = dictionary["device_token"] as? String
        deviceType = dictionary["device_type"] as? String
        email = dictionary["email"] as? String
        id = dictionary["id"] as? String
        publisherType = dictionary["publisher_type"] as? String
        url = dictionary["url"] as? String
        userName = dictionary["user_name"] as? String
    }
}
class MessCount : NSObject{

    var totalMessagecount : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        totalMessagecount = dictionary["totalMessagecount"] as? String
    }

}
