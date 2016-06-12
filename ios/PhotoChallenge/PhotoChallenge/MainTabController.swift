//
//  MainTabController.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 12/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    override func viewDidLoad() {
        API.getCategories({ categories in
                Category.all = categories
            }, error: { error in print(error.localizedDescription)})
    }
}
