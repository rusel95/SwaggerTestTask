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
        
        checkIfUserIsLoggedIn()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Exit"), style: .plain, target: self, action: #selector(handleLogout) )
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
//        if UserDefaults.standard.value(forKey: "userKey") == nil {
//            perform(#selector(handleLogout), with: nil, afterDelay: 0)
//        } else {
            getAllUsers()
//        }
    }
    
    func handleLogout() {
        
//        let loginController = LoginViewController()
//        
//        //loginController.messagesController = self
//        
//        present(loginController, animated: true, completion: nil)
    }
    
    func getAllUsers() {
        SwotseApi.shared.getAllUsers() { response in
            self.allUsers = response!
            self.tableView.reloadData()
        }
    }
    
}
