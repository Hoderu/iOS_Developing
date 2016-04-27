//
//  CoursesLoader.swift
//  inStudy_iOS
//
//  Created by Аксенов Сергей on 17.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation

class CoursesLoader {
    
    
    var courses : [Course]
    
    var classes : [Class]
    
    init? () {
        
        courses = [Course]()
        
        classes = [Class]()
        
    }
    
    func loadCourses() {
        
        let request = NSMutableURLRequest(URL: (NSURL(string: "http://instudy.io:80/api/courses/my/"))!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        
        // create some JSON data and configure the request
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "")
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
                
                classes += [Class(name: String(json["name"]!!), teacherName: teacher, time: jsonList[0]["events"]!![0]["time"]! as! String, mark:1)!]
                
                courses += [Course(name: String(json["name"]!!), timetable: jsonList[0]["events"]!![0]["time"]! as! String, mark: 1, isActive: true)!]
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
    }
}