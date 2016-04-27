//
//  ViewController.swift
//  inStudy
//
//  Created by luba_yaronskaya on 26.02.16.
//  Copyright © 2016 MIPT. All rights reserved.
//
import UIKit

class CourseTableViewController: UITableViewController {
    var active_courses = [Course]()
    var deleted_courses = [Course]()
    var editMode = false
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        tableView.tableFooterView = AddCourseView(frame: CGRect(x: 0, y: 300, width: 300, height: 30))
//      tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadCourses()
    }
    
    func loadCourses() {
        
        let course1 = Course(name: "Случайные процессы", timetable: "Занятия пт: 18:30 - 20:00", mark: 1, isActive: true)!
        
        let course2 = Course(name: "Физкультура", timetable: "Занятия чт: 18:30 - 20:00", mark: 0, isActive: true)!
        
        let course3 = Course(name: "Физика", timetable: "Занятия  ср: 18:30 - 20:00", mark: 0, isActive: true)!
        
        let courses = GlobalStorage.loader.courses
        
        for crs in courses {
            if crs.isActive {
                active_courses.append(crs)
            } else {
                deleted_courses.append(crs)
            }
        }
        
        active_courses += [course1, course2]
        
        deleted_courses += [course3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return active_courses.count
        }
        if section == 1 && editMode {
            return deleted_courses.count
        }
        if section == 2 && !editMode {
            return 1
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let course = active_courses[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("ActiveCourseTableViewCell", forIndexPath: indexPath) as! CourseTableViewCell
            cell.timetableLabel?.text = course.timetable
            cell.nameLabel?.text = course.name
            cell.mark?.rating = course.mark
            return cell
        }
        if indexPath.section == 1 {
            let course = deleted_courses[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("DeletedCourseTableViewCell", forIndexPath: indexPath) as! DeletedCourseTableViewCell
            cell.timetableLabel?.text = course.timetable
            cell.nameLabel?.text = course.name
            cell.mark?.rating = course.mark
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddCourseTableViewCell", forIndexPath: indexPath) 
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        editMode = true
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let deleted_course = active_courses.removeAtIndex(indexPath.row)
            deleted_courses.append(deleted_course)
            tableView.reloadData()
        }
        else if editingStyle == .Insert && indexPath.section == 1 {
            let added_course = deleted_courses.removeAtIndex(indexPath.row)
            active_courses.append(added_course)
            tableView.reloadData()
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if (editing) {
            editMode = true
            tableView.reloadData()
        } else {
            editMode = false
            tableView.reloadData()
        }
    }
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        if (indexPath.section == 0) {
            return .Delete
        }
        return .Insert
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddCourse" {
            print("Adding Course")
        }
    }

    
    @IBAction func unwindToMyCourses(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddCourseViewController, course = sourceViewController.course {
            let newIndexPath = NSIndexPath(forRow: active_courses.count, inSection: 0)
            active_courses.append(course)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
}
