//
//  LoginViewController.swift
//  Twitter Client
//
//  Created by samman on 2/28/17.
//  Copyright © 2017 samman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func twitterLoginButton(_ sender: Any) {
        // session manager: for making Get or Post requests using sessions
        let twitterClient = TwitterClient.sharedTwitterClient
        
        twitterClient?.login(success: {() -> () in
            // run this code when login happens successfully
            print ("I've logged in")
            
            // perform segue to the list view of tweets
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }, noSuccess: {(error: Error) -> Void in
            print ("error occured \(error)")
        })
        
//        twitterClient?.get_user(success: {(user_detail: TwitterUser) -> () in
//            print ("USERNAME \(user_detail.name!)")
//        }, noSuccess: {(error: Error) -> () in
//            print ("error: \(error)")
//        })
//        
//        
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
