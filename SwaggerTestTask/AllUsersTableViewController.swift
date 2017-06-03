//
//  AllUsersTableViewController.swift
//  SwaggerTestTask
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class AllUsersTableViewController: UITableViewController {
    
    fileprivate var allUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllUsers()
        
        checkIfUserIsLoggedIn()
        
        //        SwotseApi.shared.loginUserWith(userName: "test103", password: "111111", token: "17082b0c4ad99528891147c310fa325cb1e38f19") { key in
        //            if key != nil {
        //            UserDefaults.standard.set(response, forKey: "userKey")
        //            } else {
        //                //some alert needed
        //            }
        //        }
        
//        SwotseApi.shared.registerUserWith(userName: "test110", password: "111111", email: "test110@gmail.com") { token in
//            
//            switch token {
//            case "Email already in use"? :
//                //need alert about mistake
//                print( UserDefaults.standard.value(forKey: "token")! )
//                break
//            case nil:
//                //some alert
//                print("some error")
//                break
//                
//            default:
//                UserDefaults.standard.set(token, forKey: "token")
//            }
//        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let tempUser = allUsers[indexPath.row]
        cell.textLabel?.text = tempUser.userName
        cell.detailTextLabel?.text = tempUser.lastLogin
        
        return cell
    }
    
}


//MARK: my functions
extension AllUsersTableViewController {
    
    func checkIfUserIsLoggedIn() {
        if UserDefaults.standard.value(forKey: "token") == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                self.fetchUserAndSetupNavBarTitle()
                
            }, withCancel: nil)
        }
    }
    
    func getAllUsers() {
        SwotseApi.shared.getAllUsers() { response in
            self.allUsers = response!
            self.tableView.reloadData()
        }
    }
    
}
