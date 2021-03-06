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
        navigationItem.title="Settings"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOut(_ sender: AnyObject) {
        CURRENT_USER.unauth()
        UserDefaults.standard.setValue(nil, forKey: "uid")
    }
    
}
