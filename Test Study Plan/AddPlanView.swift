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
    private var labels = [UILabel]()
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
        dispProbs.contentSize = CGSizeMake(374,25)
        // Do any additional setup after loading the view, typically from a nib.
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
        let ref = Firebase(url: "https://test-study-plan-ios.firebaseio.com/")
        let dataRef = ref.childByAppendingPath(GlobalInfo.getUsername()+" data")
        let plan = ["Name of Plan": name]
        dataRef.updateChildValues(plan)
        let planData = ["Days Till Test": days, "Hours Per Day to Study": hrs, "Problems Wrong per Section": probsWrong, "Time to Study Per Section":timePerSec]
        dataRef.childByAppendingPath(name).setValue(planData)
    }
    
    func calculate(){
        var sumOfProbsWrong = 0.0
        for i in 0...probsWrong.capacity{
            sumOfProbsWrong+=Double(probsWrong[i])
        }
        let propScale = sumOfProbsWrong/Double(hrs)
        for i in 0...probsWrong.capacity{
            timePerSec.append(Int(Double(probsWrong[i])*propScale)*60)
        }
    }
    
}
