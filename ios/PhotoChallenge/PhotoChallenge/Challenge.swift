import Foundation
import SwiftyJSON

class Challenge{
    var name = ""
    var tag = ""
    var id = ""
    var hasSubmission : Bool = false
    var submissionImage : UIImage?
    
    
    init(name:String){
        self.name = name
    }
    
    init(json:JSON){
        print(json)
        if let id = json["id"].int {
            self.id = String(id)
        }

        if let name = json["name"].string {
            self.name = name
        }
        
        if let tag = json["tag"].string {
            self.tag = tag
        }
        
        if let hasSub = json["hasSubmission"].bool {
            self.hasSubmission = hasSub
        }
    }
    
}