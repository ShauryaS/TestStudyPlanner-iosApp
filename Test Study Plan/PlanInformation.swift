//
//  PlanInformation.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 4/17/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PlanInformation: UIViewController{
    
    var planName = "";
    @IBOutlet var planNameLable: UILabel!
    private var i = 0
    @IBOutlet var planInfoDisp: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Plan Information"
        planInfoDisp.contentSize.height = 30
        planNameLable.text = planName
        planNameLable.font = planNameLable.font.fontWithSize(25)
        planNameLable.textColor = UIColor.whiteColor()
        showPlan()
        // Do any additional setup after loading the view, typically from a nib.\
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPlan(){//error when storing data when assignments hit > 10
        CURRENT_USER.childByAppendingPath("plans").childByAppendingPath(planName).childByAppendingPath("time").queryOrderedByKey().observeEventType(.Value, withBlock: {snapshot in
            for t in snapshot.children.allObjects as! [FDataSnapshot] {
                let label = UILabel(frame: CGRectMake(0,5+(CGFloat(self.i)-2)*25,374,25))
                var tl = "Time to Study for Section "+String(self.i+1)
                tl = tl + ": "+(t.value.stringValue)+" minutes"
                label.text = tl
                label.font = label.font.fontWithSize(20)
                label.textColor = UIColor.whiteColor()
                self.planInfoDisp.addSubview(label)
                if (5+CGFloat(self.i))*25>self.planInfoDisp.contentSize.height{
                    self.planInfoDisp.contentSize.height+=30
                }
                self.i = self.i+1;
            }
        })
    }

}
