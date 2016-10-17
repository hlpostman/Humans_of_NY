//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Aristotle on 2016-10-16.
//  Copyright © 2016 Aristotle. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var postArray: NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main
        )
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler: {(dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let responseObject = responseDictionary["response"] as? [String:AnyObject] {
                        self.postArray = responseObject["posts"] as? NSArray
                    }
                }
            }
        });
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

