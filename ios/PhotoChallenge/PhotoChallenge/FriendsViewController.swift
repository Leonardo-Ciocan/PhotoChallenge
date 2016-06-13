//
//  FriendsViewController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 13/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var addTextBox: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "Friends"
        self.navigationController?.navigationBar.translucent = false
        
        
    }
    
    @IBAction func addfriend(sender: AnyObject) {
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
