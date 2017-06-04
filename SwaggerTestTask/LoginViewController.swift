//
//  LoginViewController.swift
//  SwaggerTestTask
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
    
    var loginView: LoginView! = nil
    var allUsersTableViewController: AllUsersTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HelperInstance.shared.backgroundColor
        
        loginView = LoginView( frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), viewController: self)
        loginView.delegate = self
        view.addSubview(loginView)
        
    }
}

//MARK: delegeted function
extension LoginViewController {
    func handleLoginRegister() {
        if HelperInstance.shared.isInternetAvailable() {
            if loginView.loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
                handleLogin()
            } else {
                handleRegister()
            }
        } else {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.internetConnectionErrorMessage, currentView: self)
        }
    }
    
    func handleLogin() {
        let enteredUserName = loginView.nameTextField.text!
        let enteredPassword = loginView.passwordTextField.text!
        
        if enteredUserName == "" || enteredPassword == "" {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.emptyFieldMessage, currentView: self)
        } else if enteredPassword.characters.count < 6 {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.passwordShortError, currentView: self)
        } else {
            SwotseApi.shared.loginUserWith(userName: enteredUserName, password: enteredPassword, token: HelperInstance.shared.standartToken ) { key in
                if key != nil {
                    UserDefaults.standard.set(enteredUserName, forKey: HelperInstance.shared.userNameUserDefaults)
                    UserDefaults.standard.set(key, forKey: HelperInstance.shared.keyUserDefaults)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.someShitMessage, currentView: self)
                }
            }
        }
    }
    
    func handleRegister() {
        let enteredUserName = loginView.nameTextField.text!
        let enteredPassword = loginView.passwordTextField.text!
        let enteredEmail = loginView.emailTextField.text!
        
        if enteredUserName == "" || enteredPassword == "" || enteredEmail == "" {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.emptyFieldMessage, currentView: self)
        } else if enteredPassword.characters.count < 6 {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.passwordShortError, currentView: self)
        } else {
            SwotseApi.shared.registerUserWith(userName: enteredUserName, password: enteredPassword, email: enteredEmail) { token in
                switch token {
                case HelperInstance.shared.emailInUse? :
                    HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.emailInUse, currentView: self)
                    break
                case nil:
                    HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.someShitMessage, currentView: self)
                    break
                    
                default:
                    UserDefaults.standard.set(token, forKey: HelperInstance.shared.tokenUserDefaults)
                    self.handleLogin()
                }
            }
        }
    }
}
