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
    fileprivate var i = 0
    @IBOutlet var planInfoDisp: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Plan Information"
        planInfoDisp.contentSize.height = 30
        planNameLable.text = planName
        planNameLable.font = planNameLable.font.withSize(25)
        planNameLable.textColor = UIColor.white
        showPlan()
        // Do any additional setup after loading the view, typically from a nib.\
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPlan(){//error when storing data when assignments hit > 10
        CURRENT_USER.child(byAppendingPath: "plans").child(byAppendingPath: planName).child(byAppendingPath: "time").queryOrderedByKey().observe(.value, with: {snapshot in
            for t in snapshot?.children.allObjects as! [FDataSnapshot] {
                let label = UILabel(frame: CGRect(x: 0,y: 5+(CGFloat(self.i)-3)*25,width: 374,height: 25))
                var tl = "Time to Study for Section "+String(self.i+1)
                tl = tl + ": "+((t.value as AnyObject).stringValue)+" minutes"
                label.text = tl
                label.font = label.font.withSize(15)
                label.textColor = UIColor.white
                self.planInfoDisp.addSubview(label)
                if (5+CGFloat(self.i))*25>self.planInfoDisp.contentSize.height{
                    self.planInfoDisp.contentSize.height+=30
                }
                self.i = self.i+1;
            }
        })
    }

}
