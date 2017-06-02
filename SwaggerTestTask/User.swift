//
//  AllUsers.swift
//  SwaggerTestTask
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var username: String?
    var lastLogin: String?
    
    init(username: String, lastLogin: String) {
        self.username = username
        self.lastLogin = lastLogin
    }
}

class AllUsers {
    
    var array = [User]()
    
    init(response: Any) {
        let json = JSON(response)
        print(json)
        
    }
    
}
