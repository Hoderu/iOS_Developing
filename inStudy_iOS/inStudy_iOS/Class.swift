//
//  Course.swift
//  InStudyTimeTable
//
//  Created by Аксенов Сергей on 28.02.16.
//  Copyright © 2016 Аксенов Сергей. All rights reserved.
//

import UIKit

class Class {
    // MARK: Properties
    
    var teacherName: String
    
    var name: String
    
    var time: String
    
    var mark: Int
    
    //var mark: Int
    
    // MARK: Initialization
    
    init?(name: String, teacherName: String, time: String, mark: Int) {
        self.name = name
        self.time = time
        self.teacherName = teacherName
        self.mark = mark
        
        if name.isEmpty || mark < 0 {
            return nil
        }
    }
}
