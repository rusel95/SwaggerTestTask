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
    
    //the very early check if user logged
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkIfUserIsLoggedIn()
        setNavBar()
    }
    
    func setNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Exit"), style: .plain, target: self, action: #selector(handleLogout) )
        self.navigationItem.title = UserDefaults.standard.value(forKey: "userName") as! String?
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
        if UserDefaults.standard.value(forKey: "userKey") == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            getAllUsers()
        }
    }
    
    func handleLogout() {
        SwotseApi.shared.logOut()
        let loginViewController = LoginViewController()
        loginViewController.allUsersTableViewController = self
        present(loginViewController, animated: true, completion: nil)
    }
    
    func getAllUsers() {
        SwotseApi.shared.getAllUsers() { allUsers in
            if allUsers != nil {
                self.allUsers = allUsers!
                self.tableView.reloadData()
            } else {
                print("some shit mistake while downloading")
            }
        }
    }
    
}
