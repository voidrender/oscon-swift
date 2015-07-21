//
//  ViewController.swift
//  ExternalPackages
//
//  Created by Isaac Overacker on 7/21/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET, "https://placekitten.com/g/500/500")
            .response( { (request, response, data, error) -> Void in
                switch data {
                case is NSData:
                    println("It's data with \((data as! NSData).length) bytpes")
                default:
                    println("It's something else: \(data.dynamicType)")
                }
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

