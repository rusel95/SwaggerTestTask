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
    
    
    private let apiSkeletonUrl = "http://api.openweathermap.org/data/2.5/weather"
    private let apiKeyUrl = "&appid=4a069077d6974db10f255af576ef8baa"
    private let apiAccuracyUrl = "&type=accurate"
    private let apiMetricUrl = "&units=metric"
    
    func getAllUsers(latitude: Double, longitude: Double, giveData: @escaping (WeatherResponse?) -> Void) -> Void {
        
        let locationUrl = "?lat=" + String(latitude) + "&lon=" + String(longitude)
        let urlForRequest = apiSkeletonUrl + locationUrl + apiAccuracyUrl + apiMetricUrl + apiKeyUrl
        
        Alamofire.request(urlForRequest).responseObject { (response: DataResponse<WeatherResponse>) in
            
            switch response.result {
                
            case .success:
                let weatherResponse = response.result.value!
                giveData(weatherResponse)
                
            case .failure(let error):
                print(error.localizedDescription, urlForRequest)
                giveData(nil)
            }
        }
        
    }
    
}
