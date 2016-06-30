//
//  HomeHeader.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 26/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class HomeHeader: UIView {

    
    @IBOutlet weak var txtFollowers: UILabel!
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtStars: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    var view : UIView!
    
    
    func setup() {
        // setup the view from .xib
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
        txtStars.textColor = Constants.appColor
        txtStars.text = ""
        txtUsername.text = ""
        
        API.getUserInfo({ username , stars , followers in
                self.txtStars.text = stars //+ "★"
                self.txtUsername.text = username
                self.txtFollowers.text = followers
            }, error: nil)
    }
    
    func loadViewFromNib() -> UIView {
        // grabs the appropriate bundle
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "HomeHeader", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    


}
