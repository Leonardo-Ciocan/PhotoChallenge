//
//  ChallengeHeader.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 12/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class ChallengeHeader: UICollectionReusableView {
    
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
    }
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    
    @IBOutlet weak var txtStar: UILabel!
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ChallengeHeader", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        imgStar.image = imgStar.image?.imageWithRenderingMode(.AlwaysTemplate)
        
        return view
    }
    
    func loadData(category:Category){
        imgStar.tintColor = category.color
        txtStar.textColor = category.color
    }
}
