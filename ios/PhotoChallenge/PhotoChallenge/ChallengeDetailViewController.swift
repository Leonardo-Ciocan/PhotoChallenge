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

class ChallengeDetailViewController: UIViewController , UIImagePickerControllerDelegate ,TOCropViewControllerDelegate , UINavigationControllerDelegate{

    var category : Category?
    var challenge : Challenge?
    
    @IBOutlet weak var btnShoot: UIView!

    @IBOutlet weak var imgCamera: UIImageView!
    
    
    
    @IBOutlet weak var imgHeader: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgCamera.image = imgCamera.image?.imageWithRenderingMode(.AlwaysTemplate)
        imgCamera.tintColor = UIColor.whiteColor()
        
        btnShoot.layer.cornerRadius = 5
        btnShoot.layer.masksToBounds = true
        btnShoot.backgroundColor = category?.color
        
        self.navigationItem.title = challenge?.name
        
        imgHeader.layer.shadowColor = UIColor.blackColor().CGColor
        imgHeader.layer.shadowOffset = CGSize(width: 0, height: 1)
        imgHeader.layer.shadowRadius = 5
        imgHeader.layer.shadowOpacity = 0.25
        imgHeader.layer.masksToBounds = false
        imgHeader.clipsToBounds = false
        
        if challenge!.hasSubmission && challenge!.submissionImage != nil {
                imgHeader.image = challenge?.submissionImage!
        }
        else{
            imgHeader.image = UIImage(named:"star-missing")?.imageWithRenderingMode(.AlwaysTemplate)
        }
        
        
        imgHeader.tintColor = category?.color
        
        
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(edit(_:)))
        btnShoot.addGestureRecognizer(tapped)
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
