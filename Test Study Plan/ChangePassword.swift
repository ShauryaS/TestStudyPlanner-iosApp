//
//  ChangePassword.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 4/11/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChangePassword: UIViewController{
    
    @IBOutlet var oldPassBox: UITextField!
    @IBOutlet var emailBox: UITextField!
    @IBOutlet var newPassBox: UITextField!
    @IBOutlet var confirmPassBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Change Password"
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangePassword.dismissKeyboard))
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
    
    @IBAction func changePassword(sender: AnyObject) {
        if (emailBox.text! != "" &&  oldPassBox.text! != "" && newPassBox.text! != "" && confirmPassBox.text! != ""){
            if(newPassBox.text! == confirmPassBox.text!){
                FIREBASE_REF.changePasswordForUser(emailBox.text!, fromOld: oldPassBox.text!, toNew: newPassBox.text!, withCompletionBlock: { error in
                    if error != nil{
                        let alert = UIAlertController(title: "Password Update Failed", message: "Email and/or Password Don't Match.", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else{
                        self.performSegueWithIdentifier("backToMainFromPasswordSegue", sender: nil)
                    }
                })
            }
            else{
                let alert = UIAlertController(title: "Password Update Failed", message: "New Passwords Don't Match.", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Password Update Failed", message: "Fill Textfields To Change Password.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}