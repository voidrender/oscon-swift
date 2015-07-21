//
//  ViewController.swift
//  TableView
//
//  Created by Isaac Overacker on 7/21/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let list = ["Once", "upon", "a", "time"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = self.list[indexPath.row]
        return cell
    }

}

