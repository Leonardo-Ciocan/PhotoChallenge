//
//  FriendsViewController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 13/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var addTextBox: UITextField!
    
    var friends : [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addView.backgroundColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "Friends"
        self.navigationController?.navigationBar.translucent = false
        
        addTextBox.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        addTextBox.opaque = false
        addTextBox.layer.cornerRadius = 5
        addTextBox.layer.masksToBounds = true
        
        if let placeholder = addTextBox.placeholder {
            addTextBox.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red:1,green:1,blue:1,alpha:0.5)])
        }
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        tableView.registerNib(UINib(nibName: "FriendCell",bundle: nil), forCellReuseIdentifier: "FriendCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 65
        
        API.getFriends({ friends in
            self.friends = friends
            self.tableView.reloadData()
            }, error: {_ in})
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addTextBox.resignFirstResponder()
        return true
    }
    
    func addFriend(){
        API.addFriend(addTextBox.text!, success: { friend in
                self.friends.append(friend)
                self.addTextBox.text = ""
            self.tableView.reloadData()
            }, error: { _ in
                print("not found")
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendCell
        cell.selectionStyle = .None
        cell.loadData(friends[indexPath.row])
        return cell
    }
    
    
    
    @IBAction func addfriend(sender: AnyObject) {
        addFriend()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}
