//
//  LoginViewController.swift
//  inStudy_iOS
//
//  Created by luba_yaronskaya on 03.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, RegistrationModelProtocol {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var registrationModel: RegistrationModel!
    var alertViewer: Alert!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationModel = RegistrationModel.init()
        registrationModel.delegate = self
        registrationModel.alertShowDelegate = self
        if let _emailField = emailField {
            _emailField.text = "public@example.com"
        }
        if let _passwordField = passwordField {
            _passwordField.text = "password123"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    @IBAction func tryLogin(sender: AnyObject) {
        if (emailField.text == "" || passwordField.text == "") {
            Alert().showAlertMessage(self, alertTitle: "Внимание!", alertMessage: "Заполните все поля!")
        } else {
            registrationModel.login(emailField.text!, password: passwordField.text!)
        }
    }
    
    func registrationDidLoaded() {
        NSUserDefaults.standardUserDefaults().setObject(emailField.text!, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(passwordField.text!, forKey: "userPassword")
        performSegueWithIdentifier("LoginToTimetableViewController", sender: self)
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        self.performSegueWithIdentifier("LoginToRegistrationSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "LoginToRegistrationSegue") {
            let registrationViewController = RegistrationViewController()
            (segue.destinationViewController as! RegistrationViewController).presentViewController(registrationViewController, animated: true, completion: nil)
        }
        if (segue.identifier == "LoginToTimetableViewController") {
            let timetableViewController = SWRevealViewController()
            (segue.destinationViewController as! SWRevealViewController).presentViewController(timetableViewController, animated: true, completion: nil)
        }
    }
    
    
}
