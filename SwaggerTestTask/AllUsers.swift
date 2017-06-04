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

class User: Object {
    dynamic var userName = String()
    dynamic var lastLogin = String()
    
    func myInit(userName: String?, lastLogin: String?) -> Object {
        self.userName = userName!
        self.lastLogin = lastLogin ?? ""
        return (self)
    }
}

class AllUsers {
    
    var array = [User]()
    
    init(response: Any) {
        let jsonArray = JSON(response)
    
        for userFullInfo in jsonArray {
            let tempName = userFullInfo.1["username"].string
            var tempLastLogin = userFullInfo.1["last_login"].string
            if tempLastLogin != nil {
                tempLastLogin = getProperTime(from: tempLastLogin!)
            }
            let tempUser = User().myInit(userName: tempName, lastLogin: tempLastLogin)
            array.append(tempUser as! User)
        }
    }
    
    private func getProperTime(from time: String) -> String {
        
        var temp = String()
        let index = time.index(time.startIndex, offsetBy: 16)
        let iNeededDate = time.substring(to: index)
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone.ReferenceType.default
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = formatter.date(from: iNeededDate)
        temp = DateFormatter.localizedString(from: date!, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
        
        return temp
    }
    
}