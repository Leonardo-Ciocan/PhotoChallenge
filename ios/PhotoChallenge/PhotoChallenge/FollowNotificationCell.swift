//
//  FollowNotificationCell.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 13/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class FollowNotificationCell: UITableViewCell {

    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnView.layer.cornerRadius = 5
        btnView.layer.masksToBounds = true
        btnView.backgroundColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
