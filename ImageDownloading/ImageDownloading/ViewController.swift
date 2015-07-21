//
//  ViewController.swift
//  ImageDownloading
//
//  Created by Isaac Overacker on 7/21/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func downloadImage(sender: AnyObject) {
        let URLString = "http://placekitten.com/g/500/500"
        let URL = NSURL(string: URLString)
        
        let session = NSURLSession.sharedSession()
        
        if let theURL = URL {
            let task = session.dataTaskWithURL(theURL, completionHandler: { (data, response, error) -> Void in
                if data == nil {
                    println("no data, response: \(response)")
                    return
                }
                
                if let theImage = UIImage(data: data!) {
                    NSOperationQueue.mainQueue().addOperationWithBlock() {
                        self.imageView.image = theImage
                    }
                }
            })
            
            task.resume()
        }
    }

}

