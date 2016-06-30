import UIKit
import DynamicColor

class ChallengeCell: UICollectionViewCell {
    @IBOutlet weak var imgStar: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgStar.image = imgStar.image?.imageWithRenderingMode(.AlwaysTemplate)
    }
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var txtName: UILabel!
    func loadData(challenge:Challenge , category : Category){
        //innerView.layer.backgroundColor = category.color.CGColor
        
        //txtName.textColor = category.color
        
        imgStar.tintColor = UIColor.grayColor()
        
        innerView.backgroundColor = UIColor.whiteColor()
        txtName.textColor  = UIColor.blackColor()
        
        innerView.layer.shadowColor = UIColor.blackColor().CGColor
        innerView.layer.shadowOpacity = 0.05
        innerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        innerView.layer.shadowRadius = 4
        
        self.innerView.layer.borderWidth = 1
        self.innerView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        
        //innerView.layer.cornerRadius = innerView.frame.width / 4
        //innerView.layer.masksToBounds = true
        txtName.text = challenge.name
        //txtName.textColor = category.color.lighterColor()
        
        if(challenge.hasSubmission){
            if let img = challenge.submissionImage {
                self.image.image = img
            }
            blurView.hidden = false
        }
        else{
            image.image = nil
            blurView.hidden = true
        }
    }
}
