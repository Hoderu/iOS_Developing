//
//  SecondRegistrationTableViewController.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 27.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class SecondRegistrationTableViewController: UITableViewController {

    @IBOutlet var registerButton: UIButton!
    @IBOutlet weak var registratintableView: UITableView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var groupNumberTextField: UITextField!
    class User {
        var name: String?
        var surname: String?
        var groupNumber: String?
    }
    var user: User!
    var registerAlreadyTapped: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User()
        registerAlreadyTapped = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isTestMode() -> Bool {
        return true
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        if (!registerAlreadyTapped) {
        if ((nameTextField.text!.isEmpty || surnameTextField.text!.isEmpty || groupNumberTextField.text!.isEmpty) && !isTestMode()) {
            showAlertMessage("Заполните все поля")
            return
        }
        user.name = nameTextField.text
        user.surname = surnameTextField.text
        user.groupNumber = groupNumberTextField.text
        
        NSUserDefaults.standardUserDefaults().setObject(user.name, forKey: "userName")
        NSUserDefaults.standardUserDefaults().setObject(user.surname, forKey: "userSurname")
        NSUserDefaults.standardUserDefaults().setObject(user.groupNumber, forKey: "userGroupNumber")
        NSUserDefaults.standardUserDefaults().synchronize()
        registratintableView.sectionIndexColor = UIColor.clearColor()
        registratintableView.sectionIndexBackgroundColor = UIColor.clearColor()
        for (var tableSection = 0; tableSection < registratintableView.numberOfSections - 1; tableSection++) {
            for (var row = 0; row < registratintableView.numberOfRowsInSection(tableSection); row++) {
                UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    
                    self.registratintableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: tableSection))?.alpha = 0.0
                    
                    }, completion: nil)
            }
        }
        registerButton.setTitle("Начать", forState: .Normal)
            registerAlreadyTapped = true
        } else {
            performSegueWithIdentifier("showNextStoryboard", sender: self)
        }
    }
    
    func showAlertMessage(alertMessage:String)
    {
        let alert = UIAlertController(title:"Предупреждение", message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
