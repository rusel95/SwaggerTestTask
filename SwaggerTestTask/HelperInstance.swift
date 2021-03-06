//
//  HelperInstance.swift
//  SwaggerTestTask
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit
import SystemConfiguration

class HelperInstance {
    
    static let shared = HelperInstance()
    private init () { }
    
    let backgroundColor = UIColor.rgb(r: 133, g: 187, b: 63)
    let buttonColor = UIColor.rgb(r: 88, g: 126, b: 57)
    
    let standartToken = "17082b0c4ad99528891147c310fa325cb1e38f19"
    
    let standartTitle = "OoOops.."
    let internetConnectionErrorMessage = "Looks like some trouble with connection exists.. Please, check your internet connection and try again!"
    let downloadMoreDataErrorMessage = "Can`t check if new users information exist because of internet trouble.. Please, check internet connection and try again later!"
    let emptyFieldMessage = "Looks like some of the needed fields are empty... Please, check your input data!"
    let someShitMessage = "Some shit error exists.. Don`t worry, be happy ;)"
    
    let userExistErrorMessage = "A user with this email already exists! Please, try Login or register with another email.."
    let someErrorMessage = "Sorry, but looks like some unknown error exist.. Please, try again later"
    let emailInUse = "Email already in use"
    
    let keyUserDefaults = "userKey"
    let tokenUserDefaults = "token"
    let userNameUserDefaults = "userName"
    let passwordShortError = "You have entered to short password.. It should not be shorter than 6 characters!"
    
    
    func createAlert(title: String, message: String, currentView: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Continue", style: UIAlertActionStyle.destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        currentView.present(alert, animated: true, completion: nil)
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
}

