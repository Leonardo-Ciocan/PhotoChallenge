//
//  ChallengesViewController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 10/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class ChallengesViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var challenges : [Challenge] = [
        Challenge(name: "Dog"),
        Challenge(name:"Cat"),
        Challenge(name:"Fish"),
        Challenge(name:"Swan"),
    ]
    
    var category : Category?

    
    @IBOutlet weak var categoryHeader: CategoryHeader!
    
    override func viewDidLoad() {
        self.collectionView.registerNib(UINib(nibName: "ChallengeCell", bundle: nil), forCellWithReuseIdentifier: "ChallengeCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        categoryHeader?.loadData(category!)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCell", forIndexPath: indexPath) as! ChallengeCell
        cell.loadData(self.challenges[indexPath.row], category: self.category!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.view.frame.width-30, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 10 , height: self.view.frame.width/2 - 10)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let p = scrollView.contentOffset.y / categoryHeader.frame.height
        categoryHeader.alpha = 1 - p
    }
    
}