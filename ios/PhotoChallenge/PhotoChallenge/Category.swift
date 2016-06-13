import Foundation
import UIKit
import SwiftyJSON

class Category{
    
    static var all : [Category] = []
    var challenges : [Challenge] = []
    
    var name = ""
    var id = ""
    var stars = 0
    var color = UIColor.whiteColor()
    
    init(id:String,name:String,stars:Int,color:UIColor){
        self.name = name
        self.id = id
        self.stars = stars
        self.color = color
    }
    
    init(json:JSON){
        if let name = json["name"].string {
            self.name = name
        }
        
        if let id = json["id"].string {
            self.id = id
        }
        
        if let stars = json["stars"].int {
            self.stars = stars
        }
        
        if let color = json["color"].string {
            self.color = stringToColor(color)
        }
        
    }
    
    func stringToColor(color:String) -> UIColor {
        let parts = color.componentsSeparatedByString(",").map({Int($0)})
        guard let r = parts[0] else { return UIColor.clearColor() }
        guard let g = parts[1] else { return UIColor.clearColor() }
        guard let b = parts[2] else { return UIColor.clearColor() }
        
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255 , alpha: 1)
    }
    
}