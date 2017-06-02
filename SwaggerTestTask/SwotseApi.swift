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
        
        Alamofire.request(urlForRequest).responseJSON { response in
            
            switch response.result {
                
            case .success:
                let data = response.result.value!
                
                let allUsers = AllUsers(response: data).array
                
                giveData(allUsers)
                
            case .failure(let error):
                print(error.localizedDescription, urlForRequest)
                giveData(nil)
            }
        }
        
    }
    
}
