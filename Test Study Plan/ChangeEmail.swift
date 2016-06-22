//
//  ChangeEmail.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 6/9/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChangeEmail: UIViewController{
    
    
    @IBOutlet var emailBox: UITextField!
    @IBOutlet var passBox: UITextField!
    @IBOutlet var newEmailBox: UITextField!
    @IBOutlet var conEmailBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Change Email"
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
    
    @IBAction func changeEmail(sender: AnyObject) {
        if (emailBox.text! != "" &&  passBox.text! != "" && newEmailBox.text! != "" && conEmailBox.text! != ""){
            if(newEmailBox.text! == conEmailBox.text!){
                FIREBASE_REF.changeEmailForUser(emailBox.text!, password: passBox.text!, toNewEmail: newEmailBox.text!,
                    withCompletionBlock: { error in
                        if error != nil{
                            let alert = UIAlertController(title: "Email Update Failed", message: "Email and/or Password Don't Match.", preferredStyle: UIAlertControllerStyle.Alert)
                            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                            alert.addAction(action)
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                        else{
                            self.view.makeToast(message: "Email Changed", duration: 2.0, position: HRToastPositionDefault, title: "Email")
                            self.performSegueWithIdentifier("backToMainFromEmailSegue", sender: nil)
                        }
                })
            }
            else{
                let alert = UIAlertController(title: "Email Update Failed", message: "New Emails Don't Match.", preferredStyle:    UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Email Update Failed", message: "Fill Textfields To Change Email.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}
