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
    
    @IBOutlet weak var homeHeader: HomeHeader!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor() //UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]

        
        self.navigationItem.title = "Notifications"
        self.navigationController?.navigationBar.translucent = false
        
        tableView.registerNib(UINib(nibName:"FollowNotificationCell" , bundle: nil), forCellReuseIdentifier: "follow")
        tableView.registerNib(UINib(nibName:"WelcomeCell" , bundle: nil), forCellReuseIdentifier: "welcome")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorInset = UIEdgeInsetsZero
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        tableView.tableFooterView = UIView()
        
        API.getNotifications({ ns in
            self.notifications = ns;
            self.tableView.reloadData()}, error: nil)
        let moreEvent = UITapGestureRecognizer(target: self , action: #selector(moreTouched))
        homeHeader.btnMore.gestureRecognizers?.append(moreEvent)
    }
    
    func moreTouched() {
        let alert = UIAlertController(title: "More", message: "", preferredStyle: .Alert)
        let logout = UIAlertAction(title: "Log out", style: .Destructive, handler: nil)
        alert.addAction(logout)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.tintColor = Constants.appColor
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == notifications.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("welcome") as! WelcomeCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("follow") as! FollowNotificationCell
        cell.loadData(notifications[indexPath.row].payload)
        return cell
    }
}
