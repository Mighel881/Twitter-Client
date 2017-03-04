//
//  tweetsViewController.swift
//  Twitter Client
//
//  Created by samman on 3/1/17.
//  Copyright © 2017 samman. All rights reserved.
//

import UIKit

class tweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logout(_ sender: Any) {
        TwitterClient.sharedTwitterClient?.logOut()
    }
    
    var tweets: [TwitterTweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // fetch tweets
        let twitterClient = TwitterClient.sharedTwitterClient
        
        twitterClient?.get_tweets(success: {(allTweets: [TwitterTweet]) -> Void in
            
            self.tweets = allTweets
            
            // update table
            self.tableView.reloadData()
            
        }, noSuccess: {(error: Error) -> Void in
            print ("\(error)")
        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.tweet = self.tweets[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func retweetButton(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let tweet = tweets?[(indexPath?.row)!]
        print ("before retweet>>>>>>>>>")
        TwitterClient.sharedTwitterClient?.retweet(tweet: tweet!, success: { (tweet: TwitterTweet) -> () in
            print ("retweted>>>>>>>>>")
            TwitterClient.sharedTwitterClient?.get_tweets(success: { (tweets: [TwitterTweet]) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }, noSuccess: { (error: Error) -> () in
                print(error.localizedDescription)
            })
            print("retweeted")
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
    }
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let tweet = tweets?[(indexPath?.row)!]
        
        TwitterClient.sharedTwitterClient?.favorite(tweet: tweet!, success: { (tweet: TwitterTweet) -> () in
            TwitterClient.sharedTwitterClient?.get_tweets(success: { (tweets: [TwitterTweet]) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }, noSuccess: { (error: Error) -> () in
                print(error.localizedDescription)
            })
            print("made favorite")
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell

        // get the indexpath for the given cell
        let indexPath = tableView.indexPath(for: cell)
        
        // get the movie
        let current_tweet = self.tweets![(indexPath!.row)]
        
        // get the detail view controller we segue to
        let detailViewControl = segue.destination as! TweetDetailViewController
            
        // add to the dictionary in the custom class
        detailViewControl.tweet = current_tweet
        
        print("Segue to details")
        
        
        
    }

}
