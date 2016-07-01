//
//  TodayViewController.swift
//  AppWidget
//
//  Created by Leonardo Ciocan on 01/07/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var btnCamera: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCamera.image = btnCamera.image?.imageWithRenderingMode(.AlwaysTemplate)
        btnCamera.tintColor = UIColor.whiteColor()
        btnCamera.layer.shadowColor = UIColor.blackColor().CGColor
        btnCamera.layer.shadowOffset = CGSizeZero
        btnCamera.layer.shadowOpacity = 0.5
        btnCamera.layer.shadowRadius = 5
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
