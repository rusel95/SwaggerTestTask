//
//  LoginViewController.swift
//  SwaggerTestTask
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView: LoginView! = nil
    var allUsersTableViewController: AllUsersTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HelperInstance.shared.backgroundColor
        
        loginView = LoginView( frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), viewController: self)
        view.addSubview(loginView)
    }
}

