//
//  GlobalStorage.swift
//  inStudy_iOS
//
//  Created by Аксенов Сергей on 03.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation

struct GlobalStorage {
    
    static var user = User(firstName: "Иван", secondName: "Иванов", status: "Student", university: "MIPT", group: "300",     activeCourses: nil, deletedCourses: nil)
    
    static var email : String? = ""
    
    static var password : String? = ""
    
    static var token : String = ""
    
    static var loader : CoursesLoader = CoursesLoader()!
    
}
