//
//  WelcomeCell.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 20/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class WelcomeCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var icon : UIImageView?
    
    @IBOutlet weak var btnTutorial: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        icon!.image = icon!.image?.imageWithRenderingMode(.AlwaysTemplate)
        icon?.tintColor = Constants.appColor
        
        btnTutorial.layer.cornerRadius = 0
        btnTutorial.layer.masksToBounds = true
        btnTutorial.backgroundColor = Constants.appColor
        btnTutorial.tintColor = UIColor.whiteColor()
        
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowColor = UIColor.blackColor().CGColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSizeZero
        
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
