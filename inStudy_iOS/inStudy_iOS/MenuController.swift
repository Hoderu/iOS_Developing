//
//  MenuController.swift
//  My_Chat
//
//  Created by Андрей Решетников on 07.03.16.
//  Copyright © 2016 mipt. All rights reserved.
//

import Foundation
import UIKit

class MenuController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoMenuCell", forIndexPath: indexPath) as! UserInfoMenuCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("TimetableMenuCell", forIndexPath: indexPath) as! TimetableMenuCell
            cell.timetableLabel?.text = "Timetable"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCoursesMenuCell", forIndexPath: indexPath) as! MyCoursesMenuCell
            cell.myCoursesLabel?.text = "My courses"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("SettingsMenuCell", forIndexPath: indexPath) as! SettingsMenuCell
            cell.settingsLabel?.text = "Settings"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("ChatMenuCell", forIndexPath: indexPath) as! ChatMenuCell
            cell.chatLabel?.text = "Chat"
            return cell
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier("FeedMenuCell", forIndexPath: indexPath) as! FeedMenuCell
            cell.feedLabel?.text = "Feed"
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        }

    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
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
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
