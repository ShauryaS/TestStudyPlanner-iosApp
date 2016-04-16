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
    private var i=1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="List of Plans"
        plansList.contentSize.height = 25
        loadPlans()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPlans(){
        var ref = Firebase(url: "https://test-study-plan-ios.firebaseio.com/Users")
        ref = ref.childByAppendingPath(ref.authData.uid).childByAppendingPath("Plans")
        ref.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {snapshot in
            /*let button = UIButton(frame: CGRectMake(0,(CGFloat(self.i)-1)*25,374,25))
            button.titleLabel!.text = snapshot.key
            button.titleLabel!.font = button.titleLabel!.font.fontWithSize(20)*/
            let lab = UILabel(frame: CGRectMake(0,(CGFloat(self.i)-1)*25,374,25))
            lab.font = lab.font.fontWithSize(20)
            lab.text = snapshot.key
            self.plansList.addSubview(lab)
            if (CGFloat(self.i))*25>self.plansList.contentSize.height{
                self.plansList.contentSize.height+=25
            }
            self.i=self.i+1
        })
    }
    
}