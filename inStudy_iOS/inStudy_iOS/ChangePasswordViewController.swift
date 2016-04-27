//
//  ChangePasswordViewController.swift
//  inStudy_iOS
//
//  Created by Андрей Решетников on 03.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordViewController: UITableViewController {
    
    @IBOutlet weak var CurrentPasswordText: UITextField!
    @IBOutlet weak var NewPasswordText: UITextField!
    
    @IBAction func SubmitChangePasswordButtonTap(sender: AnyObject) {
        let request = NSMutableURLRequest(URL: (NSURL(string: "http://instudy.io:80/api/auth/password/"))!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        
        let jsonString = "{\"new_password\": \"\(NewPasswordText.text!)\",\"current_password\":\"\(CurrentPasswordText.text!)\"}"
        GlobalStorage.password = NewPasswordText.text!
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "Authorization")
        
        do {
            _ = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        //look at the response
        if let httpResponse = response as? NSHTTPURLResponse {
            print("HTTP response: \(httpResponse.statusCode)")
        } else {
            print("No HTTP response")
        }
        
        self.performSegueWithIdentifier("ChangePasswordToSettingsViewController", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "ChangePasswordToSettingsViewController") {
                let settingsTableViewController = SettingsTableViewController()
                (segue.destinationViewController as! SettingsTableViewController).presentViewController(settingsTableViewController, animated: true, completion: nil)
            }
    }
    
}
    