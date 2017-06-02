//
//  Extensions.swift
//  SwaggerTestTask
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation

//
//  Extensions.swift
//  Vidvaga
//
//  Created by Admin on 30.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

extension Date {
    
    func unixToString(secondsSince1970: Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(secondsSince1970))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone.ReferenceType.local
        dateFormatter.string(from: date)
        
        return dateFormatter.string(from: date)
    }
}

private var materialKey = false
extension UIView {
    
    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        }
        set {
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.6
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
                self.layer.shadowColor = UIColor(colorLiteralRed: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
        
    }
}

private var masksToBoundsKey = false
extension UILabel {
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return masksToBoundsKey
        }
        set {
            masksToBoundsKey = newValue
            
            self.layer.masksToBounds = masksToBoundsKey
        }
    }
}

private var cornerRadiusKey : Int = 2
extension UILabel {
    
    @IBInspectable var cornerRadius: Int {
        get {
            return cornerRadiusKey
        }
        set {
            cornerRadiusKey = newValue
            
            self.layer.cornerRadius = CGFloat(cornerRadiusKey)
        }
    }
}
