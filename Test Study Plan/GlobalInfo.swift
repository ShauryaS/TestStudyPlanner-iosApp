//
//  GlobalInfo.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 4/8/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation

class GlobalInfo {
    static var username=""
    static var email=""
    static func setUsername(username:String){
        self.username = username
    }
    static func setEmail(email:String){
        self.email = email
    }
    static func getUsername() -> String {
        return username
    }
    static func getEmail() -> String {
        return email
    }
}