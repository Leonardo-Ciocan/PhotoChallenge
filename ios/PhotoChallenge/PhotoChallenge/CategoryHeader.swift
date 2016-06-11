//
//  CategoryHeader.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 11/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class CategoryHeader: UICollectionReusableView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var innerView: UIView!
    func loadViewFromNib() -> UIView {
        // grabs the appropriate bundle
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CategoryHeader", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    func loadData(category:Category){
        imageView.image = UIImage(named: category.name.lowercaseString)
        imageView.image = imageView.image?.imageWithRenderingMode(.AlwaysTemplate)
        imageView.tintColor = category.color
    }
}
