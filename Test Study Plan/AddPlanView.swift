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
    private var probsWrong = [Int]()
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var dayTF: UITextField!
    @IBOutlet var hourTF: UITextField!
    private var i=1
    private var name = ""
    private var days = 0
    private var hrs = 0
    private var timePerSec = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Create Plan"
        dispProbs.contentSize = CGSizeMake(374,25)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddPlansView.dismissKeyboard))
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
    
    @IBAction func addHWProbWrong(sender: AnyObject) {
        probsWrong.append(Int(probWrong.text!)!)
        let label = UILabel(frame: CGRectMake(0,(CGFloat(i)-1)*25,374,25))
        label.text = "Problems wrong - HW#"+String(i)+": "+probWrong.text!
        label.font = label.font.fontWithSize(20)
        label.textColor = UIColor.whiteColor()
        dispProbs.addSubview(label)
        if (CGFloat(i))*25>dispProbs.contentSize.height{
            dispProbs.contentSize.height+=25
        }
        probWrong.text=""
        probWrong.placeholder = "Problems Wrong on Homework"
        i=i+1
    }
    
    @IBAction func addPlan(sender: AnyObject) {
        name = nameTF.text!
        days = Int(dayTF.text!)!
        hrs = Int(hourTF.text!)!
        calculate()
        let ref = CURRENT_USER.childByAppendingPath("plans")
        ref.updateChildValues([name: name])
        let newRef = ref.childByAppendingPath(name).childByAppendingPath("time")
        var count = 1;
        for i in timePerSec{
            newRef.updateChildValues(["time "+String(count):i])
            count = count+1
        }
    }
    
    func calculate(){
        let sumOfProbsWrong = probsWrong.reduce(0, combine: +)
        let propScale = (Double(hrs)*Double(days))/Double(sumOfProbsWrong)
        for i in probsWrong{
            let temp = Double(i)*propScale*60
            timePerSec.append(Int(temp))
        }
    }
    
}
