//
//  BaseService.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 3/8/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://test-study-plan-ios.firebaseio.com"
let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase{
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("Users").childByAppendingPath(FIREBASE_REF.authData.uid)
    return currentUser!
}