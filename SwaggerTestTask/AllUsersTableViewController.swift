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
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

}

extension AllUsersTableViewController {
    
    func getAllUsers() {
        SwotseApi.shared.getAllUsers() {_ in 
            
        }
    }
    
    func updateUI() {
        
    }
    
}
