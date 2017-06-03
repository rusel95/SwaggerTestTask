//
//  SwotseApi.swift
//  SwaggerTestTask
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import Alamofire

class SwotseApi {
    
    static let shared = SwotseApi()
    private init() { }
    
    
    private let apiSkeletonUrl = "http://174.138.54.52/authorization/"
    
    func getAllUsers(giveData: @escaping ([User]?) -> Void) -> Void {
        
        let allUsersUrl = "allUsers/"
        let urlForRequest = apiSkeletonUrl + allUsersUrl
        
        Alamofire.request(urlForRequest).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                let data = response.result.value!
                
                let allUsers = AllUsers(response: data).array
                
                giveData(allUsers)
                
            case .failure(let error):
                debugPrint(error.localizedDescription, urlForRequest)
                giveData(nil)
            }
        }
    }
    
    func loginUserWith(userName: String, password: String, token: String, giveData: @escaping (CurrentUser?) -> Void) -> Void {
        
        let loginUrl = "login/"
        let urlForRequest = apiSkeletonUrl + loginUrl
        
        let parameters: Parameters = [
            "username": userName,
            "password": password,
            "token": token
        ]
        
        Alamofire.request(urlForRequest, method: .post, parameters: parameters).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                let data = response.result.value!
                let currentUser = CurrentUser(userName: userName, response: data)
                giveData(currentUser)
                
            case .failure(let error):
                debugPrint(error.localizedDescription, urlForRequest)
                giveData(nil)
            }
        }
    }
    
    func registerUserWith(userName: String, password: String, email: String, giveData: @escaping (String?) -> Void) -> Void {
        
        let registrationUrl = "registration/"
        let urlForRequest = apiSkeletonUrl + registrationUrl
        
        let parameters: Parameters = [
            "username": userName,
            "password": password,
            "email": email
        ]
        
        Alamofire.request(urlForRequest, method: .post, parameters: parameters).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                let data = response.result.value!
                var token = String()
                if let message = (data as? NSDictionary)?["message"] as? String {
                    token = message
                } else if let tempToken = (data as? NSDictionary)?["token"] as? String {
                    token = tempToken
                }
                giveData(token)
                
            case .failure(let error):
                debugPrint(error.localizedDescription, urlForRequest)
                giveData(nil)
            }
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "userKey")
    }
    
}
