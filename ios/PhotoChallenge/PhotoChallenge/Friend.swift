import Foundation
import SwiftyJSON

class Friend {
    var name = ""
    var stars = 0
    
    init(name:String,stars:Int){
        self.name = name
        self.stars = stars
    }
    
    init(json:JSON){
        if let name = json["name"].string {
            self.name = name
        }
        
        if let stars = json["stars"].int {
            self.stars = stars
        }
    }
}