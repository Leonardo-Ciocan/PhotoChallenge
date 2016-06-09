import Foundation
import UIKit

class Category{
    var name = ""
    var id = "0"
    var stars = 0
    var color = UIColor.whiteColor()
    
    init(id:String,name:String,stars:Int,color:UIColor){
        self.name = name
        self.id = id
        self.stars = stars
        self.color = color
    }
}