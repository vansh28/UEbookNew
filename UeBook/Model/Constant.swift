//
//  Constant.swift
//  UeBook
//
//  Created by Admin on 21/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

// Web Services Bass url

let kBaseUrl                           =  "http://dnddemo.com/ebooks/api/v1/"

// Register and login
let kCreateUser                          =     kBaseUrl +  "createUser"
let kUserLogin                           =     kBaseUrl +  "userLogin"

let kChatTextBackColor                  =     UIColor(red: 229/255, green: 253/255, blue: 201/255, alpha: 1)







let kMain                               = "Main"

//

let kImageUploadURL                      =     kBaseUrl + "upload/"
let kImageUploadURLBooks                 =     kBaseUrl + "upload/books/"

let kuser_list                           =     kBaseUrl + "user_list"
let kuser_chat                           =     kBaseUrl + "user_chat"
let kuser_chat_list                      =     kBaseUrl + "user_chat_list"
let kgetAllpopularBook                   =     kBaseUrl + "getAllpopularBook"
let kgetBookDetail                       =     kBaseUrl +  "getBookDetail"
let kgetAllbookMarkByUser                =     kBaseUrl +  "getAllbookMarkByUser"
let kgetAllNotebyUser                    =     kBaseUrl +  "getAllNotebyUser"
let kaddNote                             =     kBaseUrl +   "addNote"
let kUpdateNoteBook                      =     kBaseUrl +   "UpdateNoteBook"
let kgetUserDetails                      =     kBaseUrl +   "getUserDetails"
let kgetUserInfo                         =     kBaseUrl +    "getUserInfo"
let kuserEdit                            =     kBaseUrl +    "userEdit"
let kgetAllCategory                      =     kBaseUrl +    "getAllCategory"
let kgetBooksByTypes                     =     kBaseUrl +    "getBooksByTypes"
let kcontact_us                          =     kBaseUrl +     "contact_us"
let kforgetPassword                      =     kBaseUrl +    "forgetPassword"
let ksendFrndReq                         =     kBaseUrl +    "sendFrndReq"
let kgetFollowStatus                     =     kBaseUrl +    "getFollowStatus"
let kaddNewBook                          =     kBaseUrl +    "addNewBook"
let kaddReview                           =     kBaseUrl +    "addReview"
let kanswerQuestion                      =     kBaseUrl +    "answerQuestion"
let kupdateBookByid                      =     kBaseUrl +    "updateBookByid"
let kUpdatePrfilePic                     =     kBaseUrl +    "UpdatePrfilePic"
let kgetPendingBookByUser                =     kBaseUrl +     "getPendingBookByUser"
let kgetBookById                         =     kBaseUrl +     "getBookById"
let kgetAllRequestbyUser                 =     kBaseUrl +     "getAllRequestbyUser"
let kacceptedRequest                     =     kBaseUrl +     "acceptedRequest"


// chating api

let kgroupList                           =      kBaseUrl + "groupList"
let kgetGroupChatLists                   =      kBaseUrl  + "getGroupChatLists"
let kaddEditGroups                       =      kBaseUrl  + "addEditGroups"


//Idenfier

let kBookDescriptionViewController        =     "BookDescriptionViewController"
let kLoginViewController                  =    "LoginViewController"
let kRegisterViewController               =     "RegisterViewController"
let kHomeViewController                   =    "HomeViewController"
let kBookMarkViewController               =    "BookMarkViewController"
let kNotepadViewController                =    "NotepadViewController"
let kCategoriesViewController             =    "CategoriesViewController"
let kEditProfileViewController            =    "EditProfileViewController"
let kSWRevealViewController               =    "SWRevealViewController"
let kFirstPageViewController              =    "FirstPageViewController"
let kAddNotesViewController               =    "AddNotesViewController"
let kUserInfoViewController               =    "UserInfoViewController"
let kUserInfoUpdateViewController         =    "UserInfoUpdateViewController"
let kBooksByTypesViewController           =    "BooksByTypesViewController"
let kUploadBookViewController             =    "UploadBookViewController"
let kHelpUSViewController                 =    "HelpUSViewController"
let kForgotPasswordViewController         =    "ForgotPasswordViewController"
let kReadBookViewController               =    "ReadBookViewController"
let kChatUSViewController                 =    "ChatUSViewController"
let kChatUserDetail                       =    "ChatUserDetail"
let kWebDocmentViewController             =    "WebDocmentViewController"
let kBookAssignmentViewController         =    "BookAssignmentViewController"
let kRecordingViewController              =     "RecordingViewController"
let kImageZoomInZoomOutViewController     =      "ImageZoomInZoomOutViewController"
let kpendingBookViewController            = "pendingBookViewController"
let kPendingRequestViewController         =  "PendingRequestViewController"

//Chating View Controller
let kChatHistortyViewController           = "ChatHistortyViewController"
let kChatTapViewPagerViewController       =  "ChatTapViewPagerViewController"
let kGroupChatViewController              = "GroupChatViewController"
let kContactUSViewController              =    "ContactUSViewController"

let kTelephoneBookViewController          = "TelephoneBookViewController"
let kContactListTapViewPagerViewController = "ContactListTapViewPagerViewController"
let kcontactListViewController            =    "contactListViewController"
let kCreateGroupViewController            =     "CreateGroupViewController"
let kPopUpViewController                  =    "PopUpViewController"
//......................................................//
let kMESSAGE_TEXT             =            "text"
let kMESSAGE_EMOJI            =            "emoji"
let kMESSAGE_PHOTO            =            "image"
let kMESSAGE_VIDEO            =            "video"
let kMESSAGE_AUDIO            =            "audio"
let kMESSAGE_LOCATION         =            "location"
let kMESSAGE_DocFile          =            "docfile"
