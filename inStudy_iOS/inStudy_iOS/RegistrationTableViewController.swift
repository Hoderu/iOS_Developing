//
//  RegistrationTableViewController.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 26.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var statusPickerView: UIPickerView!
    @IBOutlet var universityPickerView: UIPickerView!
    @IBOutlet var emailTextField: UITextField!
    class User {
        var status: String?
        var university: String?
        var email: String?
    }
    var user: User!
    var statuses: [String] = [String]()
    var universities: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User()
        statuses = ["Преподаватель","Студент"]
        universities = ["МФТИ","Физтех","Физкультурный техникум","ПТУ"]
        self.statusPickerView.delegate = self
        self.statusPickerView.dataSource = self
        self.universityPickerView.delegate = self
        self.universityPickerView.dataSource = self
        statusPickerView.tag = 0
        universityPickerView.tag = 1
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return statuses.count
        } else {
            return universities.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0 {
            return "\(statuses[row])"
        } else {
            return "\(universities[row])"
        }
    }
    
    // TODO: delete this function
    func isTestMode() -> Bool {
        return true
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        if (emailTextField.text!.isEmpty && !isTestMode()) {
            showAlertMessage("Заполните поле электронной почты")
            return
        }
        user.email = emailTextField.text
        user.university = universities[universityPickerView.selectedRowInComponent(0)]
        user.status = universities[statusPickerView.selectedRowInComponent(0)]
        
        NSUserDefaults.standardUserDefaults().setObject(user.status, forKey: "userStatus")
        NSUserDefaults.standardUserDefaults().setObject(user.email, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(user.university, forKey: "userUniversity")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func showAlertMessage(alertMessage:String)
    {
                let alert = UIAlertController(title:"Предупреждение", message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(ok)
                self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(segue: UIStoryboardSegue) {
        
    }

    // MARK: - Table view data source

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }*/

    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }*/
    

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
