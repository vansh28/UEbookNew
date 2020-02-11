//
//  chat.swift
//  UeBook
//
//  Created by Admin on 20/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct Chat: Codable {
    
    var user_name: String!
    var user_image_url: String!
    var is_sent_by_me: Bool
    var text: String!
}

