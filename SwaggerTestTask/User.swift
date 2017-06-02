//
//  AllUsers.swift
//  SwaggerTestTask
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

struct User {
    var userName: String?
    var lastLogin: String?
    
    init(userName: String?, lastLogin: String?) {
        self.userName = userName
        self.lastLogin = lastLogin
    }
}

class AllUsers {
    
    var array = [User]()
    
    init(response: Any) {
        let jsonArray = JSON(response)
    
        for userFullInfo in jsonArray {
            let tempName = userFullInfo.1["username"].string
            let tempLastLogin = userFullInfo.1["last_login"].string
            let tempUser = User(userName: tempName, lastLogin: tempLastLogin)
            array.append(tempUser)
        }
    }
    
}
