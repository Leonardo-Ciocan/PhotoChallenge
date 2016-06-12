//
//  CategoriesViewController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 09/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit
import DynamicColor

class CategoriesViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    var lastColor = UIColor.clearColor()
    var categories : [Category] = []
    
    
//    [
//        Category(id: "0", name: "Animals", stars: 3, color: UIColor.greenColor().darkerColor()),
//        Category(id: "0", name: "Places", stars: 7, color: UIColor(red: 0, green: 0.7412, blue: 0.9686, alpha: 1.0) /* #00bdf7 */
//),
//        Category(id: "0", name: "People", stars: 10, color: UIColor.orangeColor()),
//    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        self.collectionView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        categories = Category.all
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.tintColor  = categories[0].color
        self.navigationController?.navigationBar.barTintColor = categories[0].color
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.collectionView.backgroundColor = categories[0].color
        lastColor = categories[0].color
        collectionView.allowsSelection = false
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.tabBarController?.tabBar.tintColor  = UIColor.blackColor()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
        cell.loadCategory(categories[indexPath.row])
        cell.btnOpen.tag = indexPath.row
        cell.btnOpen.addTarget(self, action: #selector(buttonExplore), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    var selectedIndex = 0
    func buttonExplore(sender:UIButton?){
        selectedIndex = sender!.tag
        
        API.getChallenges(String(selectedIndex) , success:{ challenges in
            self.categories[self.selectedIndex].challenges = challenges
            self.performSegueWithIdentifier("toChallenges", sender: self)
            }, error: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toChallenges"){
            (segue.destinationViewController as! ChallengesViewController).category = categories[selectedIndex]
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let cellWidth = screenWidth / 2.0
        let size = CGSizeMake(cellWidth/(1/1.5), cellWidth-15)
        return CGSize(width: self.view.frame.width + 5, height: self.view.frame.height)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pos = Int(floor(collectionView.contentOffset.x / (collectionView.contentSize.width-collectionView.frame.width) * CGFloat(categories.count-1)))
        //print("\(scrollView.contentOffset.x) out of \(scrollView.contentSize.width-collectionView.frame.width)")
        //let pos = collectionView.indexPathsForVisibleItems().sort({ $0.row > $1.row}).first
//        if let cell = self.collectionView.cellForItemAtIndexPath(pos){
//            let c = categories[collectionView.indexPathForCell(cell)!.row]
//            self.navigationController?.navigationBar.barTintColor = c.color
//            self.tabBarController?.tabBar.barTintColor = c.color
//        }
        let c = categories[pos]
//        UIView.animateWithDuration(1, animations: {
//            self.navigationController?.navigationBar.barTintColor = c.color
//            self.tabBarController?.tabBar.barTintColor = c.color
//            self.collectionView.backgroundColor = c.color
//        })
        lastColor = c.color
        self.navigationController?.navigationBar.barTintColor = c.color
        self.tabBarController?.tabBar.tintColor  = c.color
        self.collectionView.backgroundColor = c.color
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
            let percentage = collectionView.contentOffset.x / (collectionView.contentSize.width-collectionView.frame.width)
            let pos = Int(floor((collectionView.contentOffset.x / self.view.frame.width)))
            if(pos == categories.count-1){ return }
            //print("\(pos)-\(pos+1)")
            let c = categories[pos+1]
            let col = self.fadeFromColor(categories[pos].color, toColor: c.color, withPercentage: (collectionView.contentOffset.x % self.view.frame.width) / (self.view.frame.width))
        
        
            self.navigationController?.navigationBar.barTintColor = col
            self.tabBarController?.tabBar.tintColor = col
            self.collectionView.backgroundColor = col
        
    }
    
    func fadeFromColor(fromColor: UIColor, toColor: UIColor, withPercentage: CGFloat) -> UIColor {
        
        var fromRed: CGFloat = 0.0
        var fromGreen: CGFloat = 0.0
        var fromBlue: CGFloat = 0.0
        var fromAlpha: CGFloat = 0.0
        
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = 0.0
        var toGreen: CGFloat = 0.0
        var toBlue: CGFloat = 0.0
        var toAlpha: CGFloat = 0.0
        
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        //calculate the actual RGBA values of the fade colour
        var red = (toRed - fromRed) * withPercentage + fromRed;
        var green = (toGreen - fromGreen) * withPercentage + fromGreen;
        var blue = (toBlue - fromBlue) * withPercentage + fromBlue;
        var alpha = (toAlpha - fromAlpha) * withPercentage + fromAlpha;
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}