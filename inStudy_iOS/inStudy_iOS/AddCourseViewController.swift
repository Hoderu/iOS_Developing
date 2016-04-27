//
//  AddCourseViewController.swift
//  inStudy_iOS
//
//  Created by luba_yaronskaya on 23.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class AddCourseViewController: UITableViewController {
    
    var course: Course?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var beginTimeLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!

    var currentSettingName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.textColor = UIColor(red: 151.0/255, green: 193.0/255, blue: 100.0/255, alpha: 1)
        let font = UIFont(name: "Arial", size: 18.0)
        headerView.textLabel!.font = font!
    }
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let courseName = courseNameLabel.text ?? ""
            let beginTime = beginTimeLabel.text ?? ""
            let endTime = endTimeLabel.text ?? ""
            let timetable = "Занятия " + beginTime + "-" + endTime
            course = Course(name: courseName, timetable: timetable, mark: 1, isActive: true)
        }
        else if let nav = segue.destinationViewController as? UINavigationController {
            let addCourseTuneViewController = nav.topViewController as! AddCourseTuneViewController
            addCourseTuneViewController.settingName = segue.identifier
            currentSettingName = segue.identifier!
        }
    }
    
    @IBAction func unwindToAddCourse(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddCourseTuneViewController, setting = sourceViewController.settingItem {
            switch currentSettingName {
            case "Название курса":
                courseNameLabel.text = setting
                break;
            case "Место":
                placeLabel.text = setting
                break
            case "Преподаватель":
                teacherLabel.text = setting
                break
            default:
                break;
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
