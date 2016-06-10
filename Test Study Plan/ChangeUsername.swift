//
//  ChangeUsername.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 4/11/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

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
        if(newUsernameTB.text! != "" && confirmUsernameTB.text! != ""){
            if (newUsernameTB.text! == confirmUsernameTB.text!){
                let data = ["username":newUsernameTB.text!]
                CURRENT_USER.updateChildValues(data)
                self.performSegueWithIdentifier("userToPlans", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Username Update Failed.", message: "Usernames don't match.", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Username Update Failed.", message: "Fill Textfields To Change Username.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}