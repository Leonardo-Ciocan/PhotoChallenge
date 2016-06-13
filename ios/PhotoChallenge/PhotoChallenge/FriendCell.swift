//
//  FriendCell.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 13/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtStar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtStar.textColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(friend:Friend){
        txtName.text = friend.name
        txtStar.text = String(friend.stars) + "★"
    }
    
}
