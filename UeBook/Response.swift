//
//  Response.swift
//  UeBook
//
//  Created by Admin on 05/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class response : GraphRequestConnection {
    
    var name: String?
    var id: String?
    var gender: String?
    var email: String?
    var profilePictureUrl: String?

    init(rawResponse: Any?) {
        // Decode JSON from rawResponse into other properties here.
        guard let response = rawResponse as? Dictionary<String, Any> else {
            return
        }

        if let name = response["name"] as? String {
            self.name = name
        }

        if let id = response["id"] as? String {
            self.id = id
        }

        if let gender = response["gender"] as? String {
            self.gender = gender
        }

        if let email = response["email"] as? String {
            self.email = email
        }

        if let picture = response["picture"] as? Dictionary<String, Any> {

            if let data = picture["data"] as? Dictionary<String, Any> {
                if let url = data["url"] as? String {
                    self.profilePictureUrl = url
                }
            }
        }
    }
}
