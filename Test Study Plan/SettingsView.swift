//
//  SettingsView.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 3/14/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import UIKit

class SettingsView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOut(sender: AnyObject) {
        CURRENT_USER.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
    }
    
}
