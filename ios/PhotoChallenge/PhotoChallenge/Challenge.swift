import Foundation
import SwiftyJSON

class Challenge{
    var name = ""
    var id = "0"
    
    init(name:String){
        self.name = name
    }
    
    init(json:JSON){
        if let id = json["id"].string {
            self.id = id
        }

        if let name = json["name"].string {
            self.name = name
        }
    }
    
}