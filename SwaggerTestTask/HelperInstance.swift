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
    
    
    let standartToken = "17082b0c4ad99528891147c310fa325cb1e38f19"
    
    let standartTitle = "OoOops.."
    let internetConnectionErrorMessage = "Looks like some trouble with connection exists.. Please, check your internet connection and try again!"
    let emptyFieldMessage = "Looks like some of the needed fields are empty... Please, check your input data!"
    let someShitMessage = "Some shit error exists.. Don`t worry, be happy ;)"
    
    let keyUserDefaults = "userKey"
    let tokenUserDefaults = "token"
    let userNameUserDefaults = "userName"
    
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

