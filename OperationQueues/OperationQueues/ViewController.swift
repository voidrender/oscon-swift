//
//  ViewController.swift
//  OperationQueues
//
//  Created by Isaac Overacker on 7/21/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var mainQueue = NSOperationQueue.mainQueue()
        var backgroundQueue = NSOperationQueue()
        backgroundQueue.maxConcurrentOperationCount = 2
        
        mainQueue.addOperationWithBlock() {
            println("This is running on the main queue.")
        }
        
        backgroundQueue.addOperationWithBlock() {
            println("This is running on the background queue.")
        }
        
        backgroundQueue.addOperationWithBlock() {
            println("I'm on the background queue.")
            
            mainQueue.addOperationWithBlock() {
                println("I'm back on the main queue.")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

