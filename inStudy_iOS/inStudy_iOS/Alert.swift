//
//  RegistrationUser.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 06.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class Alert: NSObject {
    func showAlertMessage(showingViewController: UIViewController, alertTitle: String, alertMessage: String)
    {
        let alert = UIAlertController(title:alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(ok)
        showingViewController.presentViewController(alert, animated: true, completion: nil)
    }
}
