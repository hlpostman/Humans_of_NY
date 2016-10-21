//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Aristotle on 2016-10-16.
//  Copyright © 2016 Aristotle. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var postArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 280 // UITableViewAutomaticDimension
        // Make a GET request to Tumblr and save the relevant return info as an array of Tumblr users' posts
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
                        // print("[DEBUG]", self.postArray![0])
                        self.tableView.reloadData()
                    }
                }
            }
        })
        task.resume()
    }
    
    func refreshControlAction (refreshControl: UIRefreshControl) {
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let responseObject = responseDictionary["respone"] as? [String:AnyObject] {
                        self.postArray = responseObject["posts"] as? NSArray
                    }
                }
            }
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        })
    task.resume()
    }

    /*
    ** Both of following methods are called by the TableViewPrototypeCell when it has finished loading, we dynamically set the image URL here.
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.aristotle.TumblrTableViewPrototypeCell", for: indexPath as IndexPath) as! TumblrTableViewCell
        let urlString = self.getUrlString(id: indexPath.row)
        let url = URL(string: urlString!)
        cell.TumblrImageViewInTableCell.setImageWith(url!)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.postArray?.count {
            return count
        } else {
            return 0
        }
    }
    
    /*
    ** Gets a url based an array index of postArray
    */
    func getUrlString(id: Int) -> String? {
        let aPost = self.postArray![id] as? NSDictionary
        // print("[DEBUG] aPost:\n\(aPost?.count)")
        if let photos = aPost?["photos"] as? NSArray {
            if let photoObject = photos[0] as? NSDictionary {
                if let originalSize = photoObject["original_size"] as? NSDictionary {
//                    print("[DEBUG originalSize]: \(originalSize["url"]!)")
                    let url = originalSize["url"]! as! String
                    return url
                }
                return nil
            }
            return nil
        }
        return nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? PhotosDetailsViewController
        var indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        let urlString = self.getUrlString(id: (indexPath?.row)!)
        let url = URL(string: urlString!)
        print("[DEBUG URL + INDEXPATH", url!, (indexPath?.row)!)
        destinationViewController?.detailImageURL = url
        // place associated text (pic description) below UImageView, and photo ID
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

