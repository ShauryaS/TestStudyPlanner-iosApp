//
//  BaseService.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 3/8/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "test-study-plan-ios.firebaseIO.com"

let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase
{
    let userID = UserDefaults.standard.value(forKey: "uid") as! String
    
    let currentUser = Firebase(url: "\(FIREBASE_REF)").child(byAppendingPath: "users").child(byAppendingPath: userID)
    
    return currentUser!
}
