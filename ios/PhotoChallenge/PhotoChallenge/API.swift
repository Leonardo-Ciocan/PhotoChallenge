import UIKit
import Alamofire
import SwiftyJSON

class API {
    
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
                    if let token = json["token"].string{
                        completion(token)
                    }
                case .Failure(let error):
                    print("token-error:"+error.localizedDescription)
                }
        }
    }
    
    static func getCategories(success: (([Category]) -> ())? , error : ((NSError) -> ())?) {
        Alamofire.request(.GET ,Endpoints.categories , headers:self.headers)
            .responseJSON {
                response in
                switch(response.result){
                case .Success(_):
                    if let array = JSON(response.result.value!).array {
                        let categories = array.map({Category(json: $0)})
                        return success!(categories)
                    }
                case .Failure(let _error):
                    if let error = error {
                        error(_error)
                    }
                }
        }
    }
    
    static func getChallenges(id:String , success: (([Challenge]) -> ())? , error : ((NSError) -> ())?) {
        Alamofire.request(.GET ,Endpoints.challenges + id , headers:self.headers)
            .responseJSON {
                response in
                switch(response.result){
                case .Success(_):
                    if let array = JSON(response.result.value!).array {
                        let challenges = array.map({Challenge(json: $0)})
                        return success!(challenges)
                    }
                case .Failure(let _error):
                    if let error = error {
                        error(_error)
                    }
                }
        }
    }
    
    static func getFriends(success: (([Friend]) -> ())? , error : ((NSError) -> ())?) {
        Alamofire.request(.GET ,Endpoints.friends , headers:self.headers)
            .responseJSON {
                response in
                print(JSON(response.result.value!))

                switch(response.result){
                case .Success(_):
                    if let array = JSON(response.result.value!).array {
                        let friends = array.map({Friend(json: $0)})
                        return success!(friends)
                    }
                case .Failure(let _error):
                    if let error = error {
                        error(_error)
                    }
                }
        }
    }
    
    static func getNotifications(success: (([Notification]) -> ())? , error : ((NSError) -> ())?) {
        Alamofire.request(.GET ,Endpoints.notifications , headers:self.headers)
            .validate()
            .responseJSON {
                response in
                switch(response.result){
                case .Success(_):
                    if let array = JSON(response.result.value!).array {
                        let notifcations = array.map({Notification(json: $0)})
                        return success!(notifcations)
                    }
                case .Failure(let _error):
                    if let error = error {
                        error(_error)
                    }
                }
        }
    }
    
    static func getUserInfo(success: ((String,String,String) -> ())? , error : ((NSError) -> ())?) {
        Alamofire.request(.GET ,Endpoints.me , headers:self.headers)
            .validate()
            .responseJSON {
                response in
                switch(response.result){
                case .Success(_):
                    let json = JSON(response.result.value!)
                    success!(json["username"].string! , String(json["stars"].int!) , String(json["followers"].int!))
                case .Failure(let _error):
                    if let error = error {
                        error(_error)
                    }
                }
        }
    }
    
    static func addFriend(username : String  ,success: ((Friend) -> ())? , error : ((NSError) -> ())? ) {
        Alamofire.request(.POST , Endpoints.friends ,
                          headers:self.headers,
            parameters: ["username":username])
            .validate()
            .responseJSON{ response in
                switch(response.result){
                case .Success(_):
                    success!(Friend(json: JSON(response.result.value!)))
                case .Failure(let error):
                    print("token-error:"+error.localizedDescription)
                }
        }
    }
    
    static func getSubmissionImageForChallenge(item:Challenge , success: ((UIImage) -> ())? , error : ((NSError) -> ())?) {
        Alamofire.request(.GET , Endpoints.image + item.id , headers:self.headers)
            .validate()
            .responseData {
                response in
                switch(response.result){
                case .Success(_):
                    item.submissionImage = UIImage(data: response.result.value!)!
                    success!(item.submissionImage!)
                case .Failure(let _error):
                    if let error = error {
                        error(_error)
                    }
                }
        }
    }
    
    
    
    //load per cell , reloaddata on acquired
    
    static func submitSubmission(fileData:NSData, challengeID : String , success: (() -> ())? , error : ((NSError) -> ())?) {
        Alamofire.upload(.POST, Endpoints.challenges + challengeID, headers: self.headers, multipartFormData: {
            multipartFormData in
            
            multipartFormData.appendBodyPart(data: fileData, name: "file", fileName: "file.png", mimeType: "image/jpeg")
            }, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.response { response in
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
    
    
}