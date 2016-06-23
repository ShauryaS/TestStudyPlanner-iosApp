//
//  DeleteUser.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 6/11/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DeleteUser: UIViewController{
    
    
    @IBOutlet var emailBox: UITextField!
    @IBOutlet var passBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Delete Username"
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
    
    @IBAction func deleteUser(sender: AnyObject) {
        FIREBASE_REF.removeUser(emailBox.text!, password: passBox.text!,
            withCompletionBlock: { error in
                if error != nil {
                    let alert = UIAlertController(title: "User Deletion Failed", message: "Email and/or Password Don't Match.", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    CURRENT_USER.unauth()
                    NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
                    self.performSegueWithIdentifier("backToMainFromDeleteSegue", sender: nil)
                }
        })
    }
    
}
