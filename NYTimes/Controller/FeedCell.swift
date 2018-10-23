//
//  FeedCell.swift
//  NYTimes
//
//  Created by Bhavesh Kumbhani on 23/10/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgThumb.circle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
