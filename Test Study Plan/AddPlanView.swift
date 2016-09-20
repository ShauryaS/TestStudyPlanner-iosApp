//
//  AddPlanView.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 3/14/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Firebase
import UIKit

class AddPlansView: UIViewController{
    
    @IBOutlet var probWrong: UITextField!
    @IBOutlet var dispProbs: UIScrollView!
    fileprivate var probsWrong = [Int]()
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var dayTF: UITextField!
    @IBOutlet var hourTF: UITextField!
    fileprivate var i=1
    fileprivate var name = ""
    fileprivate var days = 0
    fileprivate var hrs = 0
    fileprivate var timePerSec = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Create Plan"
        dispProbs.contentSize = CGSize(width: 374,height: 25)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddPlansView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(AddPlansView.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddPlansView.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += keyboardSize.height
        }
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
    
    @IBAction func addHWProbWrong(_ sender: AnyObject) {
        probsWrong.append(Int(probWrong.text!)!)
        let label = UILabel(frame: CGRect(x: 0,y: (CGFloat(i)-1)*25,width: 374,height: 25))
        label.text = "Problems wrong - HW#"+String(i)+": "+probWrong.text!
        label.font = label.font.withSize(20)
        label.textColor = UIColor.white
        dispProbs.addSubview(label)
        if (CGFloat(i))*25>dispProbs.contentSize.height{
            dispProbs.contentSize.height+=25
        }
        probWrong.text=""
        probWrong.placeholder = "Problems Wrong on Homework"
        i=i+1
    }
    
    @IBAction func addPlan(_ sender: AnyObject) {
        name = nameTF.text!
        days = Int(dayTF.text!)!
        hrs = Int(hourTF.text!)!
        calculate()
        let ref = CURRENT_USER.child(byAppendingPath: "plans")
        ref?.updateChildValues([name: name])
        let newRef = ref?.child(byAppendingPath: name).child(byAppendingPath: "time")
        var count = 1;
        for i in timePerSec{
            newRef?.updateChildValues(["time "+String(count):i])
            count = count+1
        }
    }
    
    func calculate(){
        let sumOfProbsWrong = probsWrong.reduce(0, +)
        let propScale = (Double(hrs)*Double(days))/Double(sumOfProbsWrong)
        for i in probsWrong{
            let temp = Double(i)*propScale*60
            timePerSec.append(Int(temp))
        }
    }
    
}
