//
//  FollowNotificationCell.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 13/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class FollowNotificationCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnView.layer.cornerRadius = 0
        btnView.layer.masksToBounds = true
        btnView.backgroundColor = Constants.appColor
        
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowColor = UIColor.blackColor().CGColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSizeZero
        
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(follow))
        btnView.gestureRecognizers?.append(tap)
    }
    
    var username : String?
    func loadData(name:String){
        self.username = name
        let s = (name + " started following you")
        
        let attributedString = NSMutableAttributedString(string:s)
        var range = NSRange()
        range.location = 0
        range.length = name.characters.count
        attributedString.addAttribute(NSForegroundColorAttributeName, value: Constants.appColor, range: range)
        
        message.attributedText = attributedString
    }
    
    func follow() {
        API.addFriend(self.username!, success: nil, error: nil)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
