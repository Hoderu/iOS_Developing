//
//  RegistrationPrivateDataViewController.swift
//  inStudy_iOS
//
//  Created by luba_yaronskaya on 10.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class RegistrationPrivateDataViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userSurnameField: UITextField!
    @IBOutlet weak var userGroupField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (userNameField.text == "" || userSurnameField.text == "" || userGroupField.text == "") {
            Alert().showAlertMessage(self, alertTitle: "Внимание!", alertMessage: "Заполните все поля!")
        } else {
            GlobalStorage.user?.firstName = userNameField.text!
            GlobalStorage.user?.secondName = userSurnameField.text!
            GlobalStorage.user?.group = userGroupField.text!
            if (segue.identifier == "PrivateRegistrationToAddPhotoViewController") {
                let addPhotoRegistrationViewController = AddPhotoRegistrationViewController()
                (segue.destinationViewController as! AddPhotoRegistrationViewController).presentViewController(addPhotoRegistrationViewController, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func addedPrivateInfo(sender: AnyObject) {
        self.performSegueWithIdentifier("PrivateRegistrationToAddPhotoViewController", sender: self)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
}
