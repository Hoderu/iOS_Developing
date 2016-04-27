//
//  ChangeUserDataViewController.swift
//  inStudy_iOS
//
//  Created by Андрей Решетников on 23.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class ChangeUserDataViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    
    var apiURL: String!
    var profileURL: String!
    var firstNameParameterName: String!
    var secondNameParameterName: String!
    var sessionManager: AFHTTPSessionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiURL = "http://instudy.io:80/api/"
        profileURL = "profile/me/"
        firstNameParameterName = "first_name"
        secondNameParameterName = "last_name"
        sessionManager = AFHTTPSessionManager()
        sessionManager.requestSerializer = AFJSONRequestSerializer()
        sessionManager.requestSerializer.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "Authorization")
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    @IBAction func trySaveData(sender: AnyObject) {
        if (nameTextField.text == "" || surnameTextField.text == "" || groupTextField.text == "") {
            Alert().showAlertMessage(self, alertTitle: "Внимание!", alertMessage: "Заполните все поля!")
        } else {
            sessionManager.PUT(apiURL + profileURL, parameters: [firstNameParameterName: nameTextField.text!, secondNameParameterName: surnameTextField.text!], success: {(sessionDataTask, response) in
                    print("JSON response for change user data is \(response)")
                }, failure: { (sessionDataTask, error) in
                    print(error)
                    // TODO: specify error
            })
            self.performSegueWithIdentifier("ChangeUserDataToSettingsTableViewController", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ChangeUserDataToSettingsTableViewController") {
            let settingsTableViewController = SettingsTableViewController()
            (segue.destinationViewController as! SettingsTableViewController).presentViewController(settingsTableViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}