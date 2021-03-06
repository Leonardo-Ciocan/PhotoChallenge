import UIKit
import DynamicColor
class CategoryCell: UICollectionViewCell {
    
    
    @IBOutlet weak var currentStars: UILabel!
    @IBOutlet weak var maxStars: UILabel!
    
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var coreView: UIView!
    @IBOutlet weak var txtName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCategory(category:Category){
        //self.layer.backgroundColor = category.color.CGColor
//        coreView.layer.cornerRadius = 5
//        coreView.layer.masksToBounds = true
//        coreView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 100).CGColor
//        coreView.layer.borderWidth = 0
        
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = self.bounds
//        gradient.colors = [category.color.CGColor ,UIColor(red: 0.255, green: 0.255, blue: 0.255, alpha: 1.00).CGColor]
//        gradient.locations = [0,0.7]
//        self.layer.insertSublayer(gradient, atIndex: 0)
        imageView.image = UIImage(named: category.name.lowercaseString)
        imageView.image = imageView.image?.imageWithRenderingMode(.AlwaysTemplate)
        
        txtName.text = category.name.uppercaseString
//        txtName.layer.shadowColor = category.color.darkerColor().darkerColor().CGColor
//        txtName.layer.shadowOpacity = 1
//        txtName.layer.shadowOffset = CGSize(width: 0, height: 0)
//        txtName.layer.shadowRadius = 10
        
//        imageView.layer.shadowColor = category.color.darkerColor().darkerColor().CGColor
//        imageView.layer.shadowOpacity = 0.5
//        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        imageView.layer.shadowRadius = 5
        
        btnOpen.layer.cornerRadius = 5
        btnOpen.layer.masksToBounds = true
        btnOpen.layer.backgroundColor = category.color.lighterColor().CGColor
        btnOpen.titleLabel?.textColor = category.color.darkerColor()
        btnOpen.setTitleColor(category.color.darkerColor(), forState: .Normal)
        btnOpen.setTitleColor(category.color.lighterColor(), forState: .Highlighted)
                
        btnOpen.addTarget(self, action: #selector(explore), forControlEvents: .TouchUpInside)
        
        currentStars.text = "" + String(category.stars) + " "
        maxStars.text = " 20 "
    }
    
    func explore(){
        print("exploring")
    }
    
    
    
}
