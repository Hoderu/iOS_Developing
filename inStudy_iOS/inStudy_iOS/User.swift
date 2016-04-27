//
//  User.swift
//  inStudy_iOS
//
//  Created by luba_yaronskaya on 12.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    // MARK: Properties
    
    var firstName: String
    var secondName: String
    var status: String
    var activeCourses = [Course]()
    var deletedCourses = [Course]()
    var university: String
    var group: String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("users")
    
    // MARK: Types
    
    struct PropertyKey {
        static let firstNameKey = "firstName"
        static let secondNameKey = "secondName"
        static let statusKey = "status"
        static let coursesKey = "courses"
        static let universityKey = "university"
        static let groupKey = "group"
    }
    
    // MARK: Initialization
    
    init?(firstName: String, secondName: String, status: String, university: String, group: String, activeCourses: [Course]?, deletedCourses: [Course]? ) {
        self.firstName = firstName
        self.secondName = secondName
        self.status = status
        self.university = university
        self.group = group
        if let courses = activeCourses {
            self.activeCourses = courses
        }
        if let courses = deletedCourses {
            self.deletedCourses = courses
        }

        super.init()
        
        
        //TODO check for conditions
        if firstName.isEmpty || secondName.isEmpty {
            return nil
        }
        
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(firstName, forKey: PropertyKey.firstNameKey)
        aCoder.encodeObject(secondName, forKey: PropertyKey.secondNameKey)
        aCoder.encodeObject(status, forKey: PropertyKey.statusKey)
        aCoder.encodeObject(activeCourses + deletedCourses, forKey: PropertyKey.coursesKey)
        aCoder.encodeObject(university, forKey: PropertyKey.universityKey)
        aCoder.encodeObject(group, forKey: PropertyKey.groupKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let firstName = aDecoder.decodeObjectForKey(PropertyKey.firstNameKey) as! String
        let secondName = aDecoder.decodeObjectForKey(PropertyKey.secondNameKey) as! String
        let status = aDecoder.decodeObjectForKey(PropertyKey.statusKey) as! String
        let courses = aDecoder.decodeObjectForKey(PropertyKey.coursesKey) as! [Course]
        var activeCourses = [Course]()
        var deletedCourses = [Course]()
        for course in courses {
            if course.isActive {
                activeCourses.append(course)
            }
            else {
                deletedCourses.append(course)
            }
        }
        let university = aDecoder.decodeObjectForKey(PropertyKey.universityKey) as! String
        let group = aDecoder.decodeObjectForKey(PropertyKey.groupKey) as! String

        self.init(firstName: firstName, secondName: secondName, status: status, university: university, group: group, activeCourses: activeCourses, deletedCourses: deletedCourses)
    }
    
}
