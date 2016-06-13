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
    @IBOutlet weak var categoryHeader: CategoryHeader!
    
    
    var challenges : [ String : [Challenge]] = [:]
    var sections : [String] = []
    var category : Category?
    
    var selectedChallenge : Challenge?
    
    func setCategory(value : Category?){
        guard value != nil else {return}
        for item in (value?.challenges)!{
            if let _ = challenges[item.tag]{
                challenges[item.tag]!.append(item)
            }
            else{
                challenges[item.tag] = [item]
                sections.append(item.tag)
            }
            if(item.hasSubmission){
            API.getSubmissionImageForChallenge(item , success: { img in
                    self.collectionView.reloadData()
                }, error: nil)
            }
        }
        self.category = value
    }
    
    
    override func viewDidLoad() {
        self.collectionView.registerNib(UINib(nibName: "ChallengeCell", bundle: nil), forCellWithReuseIdentifier: "ChallengeCell")
        
        self.collectionView.registerClass(ChallengeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ChallengeHeader")
        collectionView.delegate = self
        collectionView.dataSource = self
        categoryHeader.hidden = true
        self.navigationItem.title = category?.name
    }
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challenges[sections[section]]!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCell", forIndexPath: indexPath) as! ChallengeCell
        cell.loadData(challenges[sections[indexPath.section]]![indexPath.row], category: self.category!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: section == sections.count - 1 ? 50 : 0, right: 10)
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
        let p = scrollView.contentOffset.y / (categoryHeader.frame.height/2.5)
        categoryHeader.alpha = 1 - p
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ChallengeHeader", forIndexPath: indexPath) as! ChallengeHeader
            header.txtName.text = sections[indexPath.section].uppercaseString
            let s : String = sections[indexPath.section]
            let cs = challenges[s]!
            header.txtStar.text = String(cs.filter({$0.hasSubmission}).count)
            header.loadData(category!)
            return header
        default:
            assert(false,"Unexpected element")
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedChallenge = challenges[sections[indexPath.section]]![indexPath.row]
        self.performSegueWithIdentifier("toDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            (segue.destinationViewController as! ChallengeDetailViewController).category = category
            (segue.destinationViewController as! ChallengeDetailViewController).challenge = selectedChallenge
        }
    }
}