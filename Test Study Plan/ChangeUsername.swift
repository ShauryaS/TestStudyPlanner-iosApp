//
//  ChangeUsername.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 4/11/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class ChangeUsername: UIViewController{
    
    @IBOutlet var oldUsernameTB: UITextField!
    @IBOutlet var newUsernameTB: UITextField!
    @IBOutlet var confirmUsernameTB: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Change Username"
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeUsername.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateUsername(sender: AnyObject) {
        
    }
    
}