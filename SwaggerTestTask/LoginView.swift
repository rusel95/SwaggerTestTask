//
//  LoginView.swift
//  SwaggerTestTask
//
//  Created by Admin on 04.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var currentViewController = UIViewController()
    
    init(frame: CGRect, viewController: UIViewController) {
        super.init(frame: frame)
        
        currentViewController = viewController
        
        self.addSubview(inputsContainerView)
        self.addSubview(loginRegisterButton)
        self.addSubview(profileImageView)
        self.addSubview(loginRegisterSegmentedControl)
        
        setupInputsContainer()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View implementation
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(r: 88, g: 126, b: 57)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(r: 133, g: 187, b: 63)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(r: 133, g: 187, b: 63)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "main")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login","Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        sc.layer.cornerRadius = 15
        return sc
    }()
    
    func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        //change height of InputContainerView!?
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        //change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //change height of emailTextField
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        emailTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0
        emailSeparatorView.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0
        
        //change height of passwordTextField
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    func setupLoginRegisterSegmentedControl(){
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputsContainer() {
        inputsContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24).isActive = true
        
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        //name text field
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameSeparatorView)
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //email text field
        inputsContainerView.addSubview(emailTextField)
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(emailSeparatorView)
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password text field
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginRegisterButton.centerYAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 36).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension LoginView {
    func handleLoginRegister() {
        if HelperInstance.shared.isInternetAvailable() {
            if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
                handleLogin()
            } else {
                handleRegister()
            }
        } else {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.internetConnectionErrorMessage, currentView: self.currentViewController)
        }
    }
    
    func handleLogin() {
        let enteredUserName = nameTextField.text!
        let enteredPassword = passwordTextField.text!
        
        if enteredUserName == "" || enteredPassword == "" {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.emptyFieldMessage, currentView: self.currentViewController)
        } else if enteredPassword.characters.count < 6 {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.passwordShortError, currentView: self.currentViewController)
        } else {
            SwotseApi.shared.loginUserWith(userName: enteredUserName, password: enteredPassword, token: HelperInstance.shared.standartToken ) { key in
                if key != nil {
                    UserDefaults.standard.set(enteredUserName, forKey: HelperInstance.shared.userNameUserDefaults)
                    UserDefaults.standard.set(key, forKey: HelperInstance.shared.keyUserDefaults)
                    self.currentViewController.dismiss(animated: true, completion: nil)
                } else {
                    HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.someShitMessage, currentView: self.currentViewController)
                }
            }
        }
    }
    
    func handleRegister() {
        let enteredUserName = nameTextField.text!
        let enteredPassword = passwordTextField.text!
        let enteredEmail = emailTextField.text!
        
        if enteredUserName == "" || enteredPassword == "" || enteredEmail == "" {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.emptyFieldMessage, currentView: self.currentViewController)
        } else if enteredPassword.characters.count < 6 {
            HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.passwordShortError, currentView: self.currentViewController)
        } else {
            SwotseApi.shared.registerUserWith(userName: enteredUserName, password: enteredPassword, email: enteredEmail) { token in
                switch token {
                case HelperInstance.shared.emailInUse? :
                    HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.emailInUse, currentView: self.currentViewController)
                    break
                case nil:
                    HelperInstance.shared.createAlert(title: HelperInstance.shared.standartTitle, message: HelperInstance.shared.someShitMessage, currentView: self.currentViewController)
                    break
                    
                default:
                    UserDefaults.standard.set(token, forKey: HelperInstance.shared.tokenUserDefaults)
                    self.handleLogin()
                }
            }
        }
    }
}
