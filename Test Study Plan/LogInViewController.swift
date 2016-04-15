//
//  LogInViewController.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 3/9/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var mainText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Firebase(url: "https://test-study-plan-ios.firebaseio.com")
        if ref.authData != nil {
            performSegueWithIdentifier("plansSegue", sender: nil)
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
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

    @IBAction func loginAction(sender: AnyObject) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != ""
        {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error == nil
                {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                }
                else
                {
                    print(error)
                }
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
