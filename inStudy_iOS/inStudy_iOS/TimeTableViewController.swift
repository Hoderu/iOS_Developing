//
//  TimeTableViewController.swift
//  InStudyTimeTable
//
//  Created by Аксенов Сергей on 28.02.16.
//  Copyright © 2016 Аксенов Сергей. All rights reserved.
//

import UIKit

class TimeTableViewController: UITableViewController {
    
    var classes = [Class]()
    var pastClasses = [Class]()
    //var presentClasses = [Class]()
    var futureClasses = [Class]()
    
    
    ////
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    ////
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        loadTimeTable()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func loadTimeTable() {
        
        let request = NSMutableURLRequest(URL: (NSURL(string: "http://instudy.io:80/api/courses/my"))!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        
        // create some JSON data and configure the request
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "Authorization")
        do
        {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            

            let jsonList : NSArray = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for json in jsonList
            {
                var teacher = ""
                
                for str in json["teachers"] as! Array<String> {
                    teacher += String(str)
                }
                self.classes += [Class(name: String(json["name"]!!), teacherName: teacher, time: jsonList[0]["events"]!![0]["time"]! as! String, mark:1)!]
            }
            
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
        //look at the response
        if let httpResponse = response as? NSHTTPURLResponse
        {
            print("HTTP response: \(httpResponse.statusCode)")
        }
        else
        {
            print("No HTTP response")
        }
        
        
        let firstClass = Class(name: "Случайные процессы", teacherName: "Шабанов Д.А.", time: "12:20:00", mark: 1)!
        let secondClass = Class(name: "Функциональный анализ", teacherName: "Коновалов С.П.", time: "13:55:00", mark: 0)!
        let thirdClass = Class(name: "Физика", teacherName: "Кузьмичев С.Д", time: "23:45:00", mark: 1)!
        let fcl = Class(name: "Инновационный практикум",teacherName: "Крапивин", time: "01:00:00", mark: 0)!
        classes += [firstClass, secondClass, thirdClass, fcl]
        
        for cls in classes
        {
            
            //////
            let classTimeString = cls.time
            let inFormatter = NSDateFormatter()
            inFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            inFormatter.dateFormat = "HH:mm"
            //let classTime = inFormatter.dateFromString(classTimeString)!
            //print(classTimeString)
            //let currentTime = NSDate()
            //print(inFormatter.stringFromDate(currentTime))
            //if (currentTime.compare(classTime) == NSComparisonResult.OrderedDescending)
            if (cls.teacherName == "Крапивин" || cls.teacherName == "Шабанов Д.А.")
            {
                pastClasses += [cls]
            }
            else
            {
                futureClasses += [cls]
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return 3
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2//classes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeTableViewCell", forIndexPath: indexPath) as! TimeTableViewCell
        
        var _class : Class
        switch (indexPath.section) {
            
        case 0:
            _class = pastClasses[indexPath.row]//classes[indexPath.row]
        
        //case 1:
        default:
            _class = futureClasses[indexPath.row]//classes[indexPath.row]
            
        //default:
            //_class = classes[indexPath.row]
            
        }
        
        cell.timeLabel.text = _class.time
        cell.nameLabel.text = _class.name
        cell.teacherLabel.text = _class.teacherName
        cell.mark.rating = _class.mark
        cell.mark.setColorAccordingToTime(_class.time)        // Configure the cell...
        return cell
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("TimetableHeaderCell") as! TimetableHeaderCell
        switch (section) {
        case 0:
            headerCell.backgroundColor = UIColor.greenColor()
            headerCell.headerLabel.text = "Past";
            //return sectionHeaderView
        default:
            headerCell.backgroundColor = UIColor.redColor()
            headerCell.headerLabel.text = "Future";
        }
        
        return headerCell
    }

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
