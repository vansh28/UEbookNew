//
//  Repository.swift
//  UeBook
//
//  Created by Admin on 21/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class AllUserListClass {
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
class AllChatListClass {
    var id: String?
    var sender: String?
    var receiver: String?
    var channelId: String?
    var type: String?
    var created: String?
    var message: String?
   
    

    init(getChatListData: NSDictionary) {
        
        self.id                = getChatListData["id"] as? String
        self.sender            = getChatListData["sender"] as? String
        self.receiver           = getChatListData["receiver"] as? String
        self.channelId           = getChatListData["channelId"] as? String
        self.type       = getChatListData["type"] as? String
        self.created             = getChatListData["created"] as? String
        self.message  = getChatListData["message"] as? String
        
        
       
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






