//
//  ViewController.swift
//  EUThreadManagerSwift
//
//  Created by Vitaliy Yarkun on 4/23/17.
//  Copyright © 2017 Vitaliy Yarkun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let threadManager = EUThreadManager.sharedInstance
    
    let taskToRunOnBackground = {
        
        for i in 0...10000{
            print("Current i: \(i)")
        }
    }
    
    let resultMethod = {
        
        print("Done!")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        threadManager.run(task: taskToRunOnBackground, with: .kDefaultPriorityExecution, and: resultMethod)
    }
}

