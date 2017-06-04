//
//  RealmCRUD.swift
//  SwaggerTestTask
//
//  Created by Admin on 04.06.17.
//  Copyright © 2017 rusel95. All rights reserved.

import Foundation
import RealmSwift

class RealmCRUD {
    
    static let shared = RealmCRUD()
    private init () { }
    
    func write(allUsers: [User]) {
        for someUser in allUsers {
            if !isExist(someUser: someUser) {
                let realm = try! Realm()
                try! realm.write {
                    realm.add(someUser)
                }
            }
        }
    }
    
    
    func queryUsersToArray() -> [User] {
        
        var allUsers = [User]()
        
        let realm = try! Realm()
        let realmUsers = realm.objects(User.self)
        for user in realmUsers {
            allUsers.append(user)
        }
        
        return allUsers
    }
    
    func isExist(someUser: User) -> Bool {
        
        var exist = false
        
        let Users = self.queryUsersToArray()
        for user in Users {
            if user.userName == someUser.userName {
                exist = true
                break
            }
        }
        
        return exist
    }
    
    func deleteAllUsers() -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
