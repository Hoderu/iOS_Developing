//
//  SettingsViewController.swift
//  inStudy_iOS
//
//  Created by Андрей Решетников on 03.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController: UITableViewController, SettingsModelProtocol {
    var settingsModel: SettingsModel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        settingsModel = SettingsModel.init()
        settingsModel.delegate = self
        settingsModel.alertShowDelegate = self
    }
    
    @IBAction func logoutButtonTap(sender: AnyObject) {
        AlertSettingsViewController().alertSettingsViewController(self, alertTitle: "Вы точно хотите выйти из своего профиля?", alertMessage: "Все данные будут удалены.", settingsModel: settingsModel)
    }
    
    func settingsDidLoaded() {
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "userPassword")
        self.performSegueWithIdentifier("SettingsToLoginViewController", sender: self)
    }
    
    @IBAction func changePasswordButtonTap(sender: AnyObject) {
        self.performSegueWithIdentifier("SettingsToChangePassworfViewController", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SettingsToChangePassworfViewController") {
            let changePasswordViewController = ChangePasswordViewController()
            (segue.destinationViewController as! ChangePasswordViewController).presentViewController(changePasswordViewController, animated: true, completion: nil)
        }
        if (segue.identifier == "SettingsToLoginViewController") {
            let loginViewController = LoginViewController()
            (segue.destinationViewController as! LoginViewController).presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}