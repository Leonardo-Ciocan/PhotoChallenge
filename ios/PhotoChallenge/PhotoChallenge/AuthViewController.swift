//
//  AuthViewController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 09/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    @IBOutlet var username : UITextField?
    @IBOutlet var password : UITextField?
    
    override func viewDidAppear(animated: Bool) {
        self.view.hidden = true
        if NSUserDefaults.standardUserDefaults().stringForKey("token") != nil{
            self.performSegueWithIdentifier("toPage", sender: self)
            print(NSUserDefaults.standardUserDefaults().stringForKey("token"))
        }
        else{
            self.view.hidden = false
        }
    }
    
    @IBAction func login(){
        API.login((username?.text)!, password: (password?.text)!, completion: { token in
            NSUserDefaults.standardUserDefaults().setValue(token, forKey: "token")
            NSUserDefaults.standardUserDefaults().synchronize()
        })
    }
}
