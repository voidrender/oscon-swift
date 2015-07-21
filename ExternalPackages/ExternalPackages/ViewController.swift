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
        
        println("GET data")
        Alamofire.request(.GET, "https://placekitten.com/g/500/500")
            .response( { (request, response, data, error) -> Void in
                switch data {
                case is NSData:
                    println("It's data with \((data as! NSData).length) bytpes")
                default:
                    println("It's something else: \(data.dynamicType)")
                }
            })
        
        println("GET JSON")
        Alamofire.request(.GET, "https://httpbin.org/get")
            .responseJSON(options: NSJSONReadingOptions.allZeros) { (request, response, data, error) -> Void in
                if let dictionary = data as? NSDictionary {
                    println("I loaded a dictionary! \(dictionary)")
                }
        }
        
        println("POST")
        Alamofire.request(.POST, "https://httpbin.org/post", parameters: ["foo": "bar"], encoding: .JSON)
            .responseJSON(options: nil) { (request, response, responseObject, error) -> Void in
                println("Received \(responseObject)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

