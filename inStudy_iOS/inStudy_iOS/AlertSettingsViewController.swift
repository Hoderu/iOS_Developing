//
//  AlertSettingsViewController.swift
//  inStudy_iOS
//
//  Created by Андрей Решетников on 19.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation
import UIKit

class AlertSettingsViewController: NSObject {
    func alertSettingsViewController(showingViewController: UIViewController,
        alertTitle: String, alertMessage: String, settingsModel: SettingsModel) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let actionOk = UIAlertAction(title: "Да", style: UIAlertActionStyle.Default, handler: { action in
            settingsModel.logout(NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!, password: NSUserDefaults.standardUserDefaults().stringForKey("userPassword")!)
        })
        alert.addAction(actionOk)
        
        let actionCancel = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(actionCancel)
        
        showingViewController.presentViewController(alert, animated: true, completion: nil)
        
    }
}