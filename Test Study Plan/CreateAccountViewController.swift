
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.dismissKeyboard))
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
    
    @IBAction func createAccount(sender: AnyObject) {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text
        let username = self.usernameTextField.text!
    
        if email != "" && password != ""
        {
            FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, authData) -> Void in
                if error == nil
                {
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                        print("in")
                        if error == nil
                        {
                            /*let data = ["username": username]
                            FIREBASE_REF.childByAppendingPath("Users").childByAppendingPath(authData.uid).setValue(data)
                            self.dismissViewControllerAnimated(true,completion: nil)*/
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            print("Account Created :)")
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