
//
//  CreateAccountViewController.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 3/9/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
    
        if email != "" && password != ""
        {
            FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, authData) -> Void in
                if error == nil
                {
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                        print("in")
                        if error == nil
                        {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            let ref = Firebase(url: "https://test-study-plan-ios.firebaseio.com/")
                            let dataRef = ref.childByAppendingPath(self.usernameTextField.text!+" data")
                            let data = ["username": self.usernameTextField.text!]
                            dataRef.setValue(data)
                            self.dismissViewControllerAnimated(true,completion: nil)
                        }
                        else
                        {
                            print(error)
                        }
                    })
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
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.emailTextField.text="";
        self.passwordTextField.text="";
    }
    
}