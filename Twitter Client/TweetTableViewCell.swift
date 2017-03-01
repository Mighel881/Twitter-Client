//
//  TweetTableViewCell.swift
//  Twitter Client
//
//  Created by samman on 3/1/17.
//  Copyright © 2017 samman. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet : TwitterTweet! {
        didSet {
            tweetText.text = tweet.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
