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
    
    var categories : [Category] = [
        Category(id: "0", name: "Animals", stars: 0, color: UIColor.greenColor().darkerColor()),
        Category(id: "0", name: "Buildings", stars: 0, color: UIColor.redColor()),
        Category(id: "0", name: "People", stars: 0, color: UIColor.purpleColor()),
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        self.collectionView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.barTintColor = categories[0].color
        self.navigationController?.navigationBar.barTintColor = categories[0].color

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
        return cell
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
        print("\(scrollView.contentOffset.x) out of \(scrollView.contentSize.width-collectionView.frame.width)")
        //let pos = collectionView.indexPathsForVisibleItems().sort({ $0.row > $1.row}).first
//        if let cell = self.collectionView.cellForItemAtIndexPath(pos){
//            let c = categories[collectionView.indexPathForCell(cell)!.row]
//            self.navigationController?.navigationBar.barTintColor = c.color
//            self.tabBarController?.tabBar.barTintColor = c.color
//        }
        let c = categories[pos]
        self.navigationController?.navigationBar.barTintColor = c.color
        self.tabBarController?.tabBar.barTintColor = c.color

        
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
