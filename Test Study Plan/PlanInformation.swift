//
//  PlanInformation.swift
//  Test Study Plan
//
//  Created by Shaurya Srivastava on 4/17/16.
//  Copyright © 2016 Shaurya Srivastava. All rights reserved.
//

import Foundation
import UIKit

class PlanInformation: UIViewController{
    
    var planName = "";
    @IBOutlet var planNameLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Plan Information"
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
    
    func showPlan(){
        
    }

}
