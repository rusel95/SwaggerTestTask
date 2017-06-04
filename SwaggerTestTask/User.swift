//
//  User.swift
//  SwaggerTestTask
//
//  Created by Admin on 04.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    dynamic var userName = String()
    dynamic var lastLogin = String()
    
    func myInit(userName: String?, lastLogin: String?) -> Object {
        self.userName = userName!
        self.lastLogin = lastLogin ?? ""
        return (self)
    }
}
