//
//  LoginViewController.swift
//  SwaggerTestTask
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let backgroundColor = UIColor.rgb(r: 133, g: 187, b: 63)
    let buttonColor = UIColor.rgb(r: 88, g: 126, b: 57)
    
    var loginView: LoginView! = nil
    var allUsersTableViewController: AllUsersTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView( frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), viewController: self)
        view.addSubview(loginView)
        
        view.backgroundColor = backgroundColor
    }
}

