//
//  PlansView.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 3/13/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import UIKit
import Firebase

class PlansView: UIViewController{
    
    @IBOutlet var plansList: UIScrollView!
    private var i=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.redColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationItem.title="List of Plans"
        plansList.contentSize.height = 45
        loadPlans()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPlans(){
        print(CURRENT_USER)
        CURRENT_USER.childByAppendingPath("plans").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {snapshot in
            let button = UIButton(frame: CGRectMake(0,5+(CGFloat(self.i))*35,450,25))
            button.titleLabel!.font = button.titleLabel!.font.fontWithSize(25)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.setTitle(snapshot.key, forState: .Normal)
            button.addTarget(self, action: #selector(PlansView.dispPlan(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.plansList.addSubview(button)
            if (5+CGFloat(self.i)+1)*35>self.plansList.contentSize.height{
                self.plansList.contentSize.height+=40
            }
            self.i=self.i+1
        })
    }
    
    func dispPlan(sender:UIButton!){
        self.performSegueWithIdentifier("planInfoSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "planInfoSegue"==segue.identifier{
            let yourNextViewController = (segue.destinationViewController as! PlanInformation)
            yourNextViewController.planName = (sender?.titleLabel!?.text!)!
        }
    }
    
}