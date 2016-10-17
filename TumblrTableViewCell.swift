//
//  TumblrTableViewCell.swift
//  Tumblr
//
//  Created by Aristotle on 2016-10-16.
//  Copyright © 2016 Aristotle. All rights reserved.
//

import UIKit

class TumblrTableViewCell: UITableViewCell {

    @IBOutlet weak var TumblrImageViewInTableCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
