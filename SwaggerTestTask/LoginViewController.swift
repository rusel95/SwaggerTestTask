//
//  LoginViewController.swift
//  SwaggerTestTask
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

//MARK: my functions
extension LoginViewController {
    
    func login() {
        SwotseApi.shared.loginUserWith(userName: "test103", password: "111111", token: "17082b0c4ad99528891147c310fa325cb1e38f19") { key in
            if key != nil {
                UserDefaults.standard.set(key, forKey: "userKey")
            } else {
                //some alert needed
            }
        }
    }
    
    func register() {
        SwotseApi.shared.registerUserWith(userName: "test110", password: "111111", email: "test110@gmail.com") { token in
            
            switch token {
            case "Email already in use"? :
                //need alert about mistake
                print( UserDefaults.standard.value(forKey: "token")! )
                break
            case nil:
                //some alert
                print("some error")
                break
                
            default:
                UserDefaults.standard.set(token, forKey: "token")
            }
        }
    }
    
}
