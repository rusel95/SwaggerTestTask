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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserIsLoggedIn()
        setNavBar()
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
    
    func setNavBar() {
        self.navigationItem.title = UserDefaults.standard.value(forKey: HelperInstance.shared.userNameUserDefaults) as! String?
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "logout1"), style: .done, target: self, action: #selector(handleLogout) )
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = HelperInstance.shared.buttonColor
    }
    
    func checkIfUserIsLoggedIn() {
        if UserDefaults.standard.value(forKey: HelperInstance.shared.keyUserDefaults) == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            
            //download users from realm and update UI if realm is not empty
            allUsers = RealmCRUD.shared.queryUsersToArray()
            
            if allUsers.count != 0 {
                self.tableView.reloadData()
            }
            
            //check for new info
            if HelperInstance.shared.isInternetAvailable() {
                getAllUsers()
            } else {
                HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.internetConnectionErrorMessage, currentView: self)
            }
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
                if self.allUsers.count < allUsers!.count {
                    RealmCRUD.shared.write(allUsers: allUsers!)
                    self.allUsers = allUsers!
                    self.tableView.reloadData()
                }
            } else {
                HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.someShitMessage, currentView: self)
            }
        }
    }
    
}
