//
//  ViewController.swift
//  ExternalPackages
//
//  Created by Isaac Overacker on 7/21/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit
import Alamofire
import SQLite

class ViewController: UIViewController {
    
    var myManager : Manager?

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
        
        println("Manipulating headers")
        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["X-Hello"] = "Yes"
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = defaultHeaders
        
        myManager = Manager(configuration: configuration)
        myManager?.request(.GET, "https://httpbin.org/get")
            .responseString(encoding: nil, completionHandler: { (request, response, string, error) -> Void in
                println("received: \(string)")
            })
        
        // SQLite.swift example
        let db = Database()

        // Begin constructing a query for users, which will be used to create the table.
        let users = db["users"]
        
        // Columns for the users table
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let email = Expression<String>("email")
        
        // Create the users table
        db.create(table: users, ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(email, unique: true)
        }
        
        // Insert
        var alice : Query?
        if let rowID = users.insert(name <- "Alice", email <- "alice@mac.com").rowid { // The <- operator is defined by SQLite.swift
            alice = users.filter(id == rowID)
        }
        
        // Update
        alice?.update(email <- "alice@gmail.com")
        
        // Query by iteration
        for user in users {
            println("User: \(user[id]), name: \(user[name])")
        }
        
        // Query with raw SQL
        let query = db.prepare("SELECT id, email FROM users")
        query.run()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

