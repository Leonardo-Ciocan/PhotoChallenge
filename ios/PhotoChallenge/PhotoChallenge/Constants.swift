import UIKit

class Endpoints {
    static let root          = "http://127.0.0.1:8000/"
    static let token         = Endpoints.root + "token/"
    static let categories    = Endpoints.root + "categories/"
    static let notifications = Endpoints.root + "notifications/"
    static let challenges    = Endpoints.root + "challenges/"
    static let image         = Endpoints.root + "image/"
    static let friends       = Endpoints.root + "friends/"
    static let me            = Endpoints.root + "me/"
}

class Constants {
    static let appColor = UIColor(red: 0/255, green: 127/255, blue: 219/255, alpha: 1.0)
}