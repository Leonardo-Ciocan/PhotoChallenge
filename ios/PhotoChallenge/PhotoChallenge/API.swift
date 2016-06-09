import UIKit
import Alamofire
import SwiftyJSON

class API{
    static var headers : Dictionary<String,String> {
        get{
            return ["Authorization":"Token " + NSUserDefaults.standardUserDefaults().stringForKey("token")!]
        }
    }
    
    static func login(username : String , password :String , completion : (String)->() ) {
        Alamofire.request(.POST , Endpoints.token ,
            parameters: ["username":username , "password":password])
            .responseJSON{ response in
                switch(response.result){
                case .Success(_):
                    let json = JSON(response.result.value!)
                    print(response.result.value!)
                    if let token = json["token"].string{
                        completion(token)
                    }
                case .Failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}