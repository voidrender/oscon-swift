//
//  ViewController.swift
//  oscon2015Tool
//
//  Created by Isaac Overacker on 7/20/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var osconLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(sender: UIButton) {
        self.osconLabel.text = "Hi there"
    }

}

