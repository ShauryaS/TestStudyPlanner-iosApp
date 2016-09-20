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
    fileprivate var i=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.red
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.title="List of Plans"
        plansList.contentSize.height = 40
        loadPlans()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPlans(){
        print(CURRENT_USER)
        CURRENT_USER.child(byAppendingPath: "plans").queryOrderedByKey().observe(.childAdded, with: {snapshot in
            let button = UIButton(frame: CGRect(x: 0,y: 5+(CGFloat(self.i))*35,width: 450,height: 25))
            button.titleLabel!.font = button.titleLabel!.font.withSize(25)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitle(snapshot?.key, for: UIControlState())
            button.addTarget(self, action: #selector(PlansView.dispPlan(_:)), for: UIControlEvents.touchUpInside)
            self.plansList.addSubview(button)
            if (5+CGFloat(self.i)+1)*35>self.plansList.contentSize.height{
                self.plansList.contentSize.height+=40
            }
            self.i=self.i+1
        })
    }
    
    func dispPlan(_ sender:UIButton!){
        self.performSegue(withIdentifier: "planInfoSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "planInfoSegue"==segue.identifier{
            let yourNextViewController = (segue.destination as! PlanInformation)
            yourNextViewController.planName = ((sender as AnyObject).titleLabel!?.text!)!
        }
    }
    
}
