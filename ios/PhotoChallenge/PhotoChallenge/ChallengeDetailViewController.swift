//
//  ChallengeDetailViewController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 12/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit
import DynamicColor
import TOCropViewController
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}
class ChallengeDetailViewController: UIViewController , UIImagePickerControllerDelegate ,TOCropViewControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var placeholder: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    var category : Category?
    var challenge : Challenge?
    
    @IBOutlet weak var friendButton: UIView!
    @IBOutlet weak var btnShoot: UIView!

    @IBOutlet weak var imgCamera: UIImageView!
    
    @IBOutlet weak var blur: UIVisualEffectView!
    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var btnDelete: UIView!
    
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var lblTakePicture: UILabel!
    @IBOutlet weak var imgHeader: UIImageView!
    
    var fromCellFrame : CGRect = CGRectZero
    
    
    var currentFrame : CGRect  = CGRectZero
    var lastCell : UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // imgCamera.image = imgCamera.image?.imageWithRenderingMode(.AlwaysTemplate)
       // imgCamera.tintColor = UIColor.whiteColor()
        
        //btnShoot.layer.cornerRadius = 5
        //btnShoot.layer.masksToBounds = true
        //btnShoot.backgroundColor = category?.color
        
        blur.backgroundColor = UIColor.blackColor().adjustedAlphaColor(-0.65)
        blur.alpha = 0.9
        
        self.navigationItem.title = challenge?.name
        
        shadowView.layer.shadowColor = UIColor.blackColor().CGColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.masksToBounds = false
        shadowView.clipsToBounds = false
        
        if challenge!.hasSubmission && challenge!.submissionImage != nil {
                imgHeader.image = challenge?.submissionImage!
                placeholder.image = challenge?.submissionImage!
        }
        else{
            imgHeader.image = UIImage(named:"star-missing")?.imageWithRenderingMode(.AlwaysTemplate)
        }
        
        
        imgHeader.tintColor = category?.color
        
        
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(edit(_:)))
        btnShoot.addGestureRecognizer(tapped)
        
//        do {
//        let maskPath = UIBezierPath(roundedRect: stackview.bounds, byRoundingCorners: [.BottomLeft, .BottomRight], cornerRadii: CGSizeMake(10, 10))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = self.stackview.bounds
//        maskLayer.path  = maskPath.CGPath
//        stackview.layer.mask = maskLayer
//        stackview.setNeedsDisplay()
//        }
//        
//        do{
//            let maskPath = UIBezierPath(roundedRect: self.imgHeader.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(10, 10))
//            let maskLayer = CAShapeLayer()
//            maskLayer.frame = self.imgHeader.bounds
//            maskLayer.path  = maskPath.CGPath
//            imgHeader.layer.mask = maskLayer
//            imgHeader.setNeedsDisplay()
//        }
        
    
        
        btnShoot.clipsToBounds = true
        btnShoot.layer.masksToBounds = true
        btnShoot.layer.borderWidth = 1
        btnShoot.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).CGColor
        
        btnDelete.layer.borderWidth = 1
        btnDelete.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).CGColor

        
        friendButton.layer.borderWidth = 1
        friendButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).CGColor

        
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panDown))
        imgHeader.addGestureRecognizer(pan)
        
        //topMargin.constant = self.view.frame.height + 10
       
        
        imgHeader.alpha = 0
        btnShoot.alpha = 0
        btnDelete.alpha = 0
        friendButton.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        
        print(fromCellFrame.origin.y)
        currentFrame = imgHeader.frame
        placeholder.frame = self.fromCellFrame
        
        UIView.setAnimationCurve(.EaseOut)
        UIView.animateWithDuration(0.5, animations: {
            self.placeholder.frame = self.currentFrame
            }, completion: { _ in
                self.placeholder.hidden = true
                self.imgHeader.alpha = 1
                UIView.animateWithDuration(0.25, animations: {
                    self.btnShoot.alpha = 1
                    self.btnDelete.alpha = 1
                    self.friendButton.alpha = 1
                    }, completion: nil)
        })
    }
    
    func panDown(sender:UIPanGestureRecognizer){
        
        if sender.state == UIGestureRecognizerState.Ended {
            if topMargin.constant >= 50 + 150 {
                
                imgHeader.alpha = 0
                btnShoot.alpha = 0
                btnDelete.alpha = 0
                friendButton.alpha = 0
                placeholder.frame = imgHeader.frame
                self.placeholder.hidden = false
                UIView.animateWithDuration(0.5, animations: {
                        self.placeholder.frame = self.fromCellFrame
                        self.blur.alpha = 0
                    }, completion: { _ in
                        self.dismissViewControllerAnimated(false, completion: {
                            self.lastCell?.hidden = false
                        })
                })
            }
            else{
            topMargin.constant = 50
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
                self.blur.alpha = 1
            })
            }
            return
        }
        
        
        
        let translation = sender.translationInView(imgHeader)
        let verticalMovement = translation.y / imgHeader.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        topMargin.constant = 50 + progress * 600
        blur.alpha = 0.9 - progress * 0.5
    }
    
    override func viewDidLayoutSubviews() {
        btnDelete.roundCorners([.BottomLeft,.BottomRight], radius: 10)
        imgHeader.roundCorners([.TopLeft , .TopRight], radius: 10)
    }
    
    func edit(sender: UITapGestureRecognizer) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let cameraOption = UIAlertAction(title: "Camera", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .Camera
            self.presentViewController(picker, animated: true, completion: nil)
        })
        
        let libOption = UIAlertAction(title: "Library", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
        })
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .Cancel, handler: { _ in optionMenu.dismissViewControllerAnimated(true, completion: nil)})
        
        optionMenu.addAction(cameraOption)
        optionMenu.addAction(libOption)
        optionMenu.addAction(cancelOption)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        optionMenu.view.tintColor = category?.color
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        let cropview = TOCropViewController(image: info[UIImagePickerControllerOriginalImage] as! UIImage)
        cropview.delegate = self
        cropview.customAspectRatio = CGSize(width: 1, height: 1)
        cropview.aspectRatioPreset = .PresetSquare
        cropview.aspectRatioLockEnabled = true
        self.presentViewController(cropview, animated: true, completion: nil)
    }
    
    func cropViewController(cropViewController: TOCropViewController!, didCropToImage img: UIImage!, withRect cropRect: CGRect, angle: Int){
        self.imgHeader.alpha = 0
        self.imgHeader.image = img
        cropViewController.dismissAnimatedFromParentViewController(self, toFrame: self.imgHeader.frame, completion: {() -> Void in
            self.imgHeader.alpha = 1
            self.setPhoto(img)
        })
    }
    
    func setPhoto(img: UIImage){
        API.submitSubmission(UIImageJPEGRepresentation(resizeImage(img, newHeight: 500), 100)!, challengeID: (challenge?.id)!, success: nil, error: nil)
        challenge?.hasSubmission = true
        challenge?.submissionImage = img
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
