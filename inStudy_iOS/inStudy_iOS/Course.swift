//
//  Course.swift
//  inStudy
//
//  Created by luba_yaronskaya on 27.02.16.
//  Copyright © 2016 MIPT. All rights reserved.
//

import UIKit

class Course: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var timetable: String
    var mark: Int
    var isActive: Bool
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("courses")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let timetableKey = "timetable"
        static let markKey = "mark"
        static let isActiveKey = "isActive"
    }
    
    // MARK: Initialization
    
    init?(name: String, timetable: String, mark: Int, isActive: Bool) {
        self.name = name
        self.timetable = timetable
        self.mark = mark
        self.isActive = isActive
        super.init()
        
        if name.isEmpty || mark < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(timetable, forKey: PropertyKey.timetableKey)
        aCoder.encodeObject(mark, forKey: PropertyKey.markKey)
        aCoder.encodeObject(isActive, forKey: PropertyKey.isActiveKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let timetable = aDecoder.decodeObjectForKey(PropertyKey.timetableKey) as! String
        let mark = aDecoder.decodeObjectForKey(PropertyKey.markKey) as! Int
        let isActive = aDecoder.decodeObjectForKey(PropertyKey.isActiveKey) as! Bool
        
        self.init(name: name, timetable: timetable, mark: mark, isActive: isActive)
    }

}
