//
//  AddPhotoRegistrationViewController.swift
//  inStudy_iOS
//
//  Created by luba_yaronskaya on 03.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class AddPhotoRegistrationViewController: UIViewController, RegistrationModelProtocol {
    var registrationModel: RegistrationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationModel = RegistrationModel.init()
        registrationModel.delegate = self
        registrationModel.alertShowDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func tryRegistration(sender: AnyObject) {
        registrationModel.register(GlobalStorage.email!, password: GlobalStorage.password!)
    }
    
    func registrationDidLoaded() {
        NSUserDefaults.standardUserDefaults().setObject(GlobalStorage.email!, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(GlobalStorage.password!, forKey: "userPassword")
        performSegueWithIdentifier("AddPhotoToTimetableViewController", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AddPhotoToTimetableViewController") {
            let timetableViewController = SWRevealViewController()
            (segue.destinationViewController as! SWRevealViewController).presentViewController(timetableViewController, animated: true, completion: nil)
        }
    }
}
