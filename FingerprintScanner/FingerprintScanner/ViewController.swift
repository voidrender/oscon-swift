//
//  ViewController.swift
//  FingerprintScanner
//
//  Created by Isaac Overacker on 7/21/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    let authenticationContext = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func authenticate(sender: AnyObject) {
        let policy = LAPolicy.DeviceOwnerAuthenticationWithBiometrics
        
        var error : NSError? = nil
        let canAuthenticate = authenticationContext.canEvaluatePolicy(policy, error: &error)
        if canAuthenticate == false {
            println("Cannot authenticate: \(error)")
            return
        }
        
        let reason = "You're about to spend money"
        
        authenticationContext.evaluatePolicy(policy, localizedReason: reason) { (succeeded, error) -> Void in
            if succeeded {
                let alert = UIAlertController(title: "Success!", message: "Biometric scanning succeeded. Money spent.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Failure!", message: "Biometric scanning failed.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }

}

