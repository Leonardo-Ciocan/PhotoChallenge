//
//  HomeViewController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 13/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var notifications : [Notification] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "Notifications"
        self.navigationController?.navigationBar.translucent = false
        
        tableView.registerNib(UINib(nibName:"FollowNotificationCell" , bundle: nil), forCellReuseIdentifier: "follow")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        API.getNotifications({ ns in
            self.notifications = ns;
            self.tableView.reloadData()}, error: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("follow") as! FollowNotificationCell
        
        return cell
    }
}
