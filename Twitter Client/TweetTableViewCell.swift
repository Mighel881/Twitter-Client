//
//  TweetTableViewCell.swift
//  Twitter Client
//
//  Created by samman on 3/1/17.
//  Copyright © 2017 samman. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailButton: UIButton!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    
    var tweet : TwitterTweet! {
        didSet {
            //thumbnailButton.setImage(UIImage(), for: .normal)
            //thumbnailButton.imageView?.setImageWith(tweet.imageUrl as URL)
            thumbnailImageView.setImageWith(tweet.imageUrl as URL)
            displayNameLabel.text = tweet.name
            tweetText.text = tweet.text
            usernameLabel.text = "@\(tweet.username)"

            if (tweet.favorite == true) {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }
            
            if (tweet.retweet == true) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            }
            
            // for time label
            if let timeStamp = tweet.timeStamp {
                timeStampLabel.text = TwitterClient.timeSince(timeStamp: timeStamp as Date)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbnailImageView.layer.cornerRadius = 3
        thumbnailImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
