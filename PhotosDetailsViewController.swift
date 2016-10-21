//
//  PhotosDetailsViewController.swift
//  Tumblr
//
//  Created by Aristotle on 2016-10-19.
//  Copyright © 2016 Aristotle. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosDetailsViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView?
    var detailImageURL: URL?
    
    @IBOutlet weak var picNumberLabel: UILabel!
    @IBOutlet weak var contentInTheory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImage?.setImageWith(self.detailImageURL!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
