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
    
    @IBAction func deleteUser(_ sender: AnyObject) {
        FIREBASE_REF?.removeUser(emailBox.text!, password: passBox.text!,
            withCompletionBlock: { error in
                if error != nil {
                    let alert = UIAlertController(title: "User Deletion Failed", message: "Email and/or Password Don't Match.", preferredStyle: UIAlertControllerStyle.alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    CURRENT_USER.unauth()
                    UserDefaults.standard.setValue(nil, forKey: "uid")
                    self.performSegue(withIdentifier: "backToMainFromDeleteSegue", sender: nil)
                }
        })
    }
    
}
