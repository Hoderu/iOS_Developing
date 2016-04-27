//
//  RegistrationViewController.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 07.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, NSURLSessionDelegate {
    
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        if (userEmailField.text == "" || userPasswordField.text == "") {
            Alert().showAlertMessage(self, alertTitle: "Внимание!", alertMessage: "Заполните все поля!")
        } else {
            GlobalStorage.email = userEmailField.text!
            GlobalStorage.password = userPasswordField.text!
            self.performSegueWithIdentifier("RegistrationToProvateRegistrationViewController", sender: self)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "RegistrationToProvateRegistrationViewController") {
            let registrationPrivateDataViewController = RegistrationPrivateDataViewController()
            (segue.destinationViewController as! RegistrationPrivateDataViewController).presentViewController(registrationPrivateDataViewController, animated: true, completion: nil)
        }
    }
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
