//
//  UserData.swift
//  inStudy_iOS
//
//  Created by Андрей Решетников on 06.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation

class UserData {
    static let sharedData = UserData()
    private init() {
        userPassword = ""
        userEmail = ""
    }
    
    var userPassword: String?
    var userEmail: String?
    var error: NSError?
    
    func getPassword() -> String {
        if let check_string = NSUserDefaults.standardUserDefaults().stringForKey("userPassword") {
            return check_string
        } else {
            print("Cann't get user password from NSUserDefaults")
            return ""
        }
    }
    
    func getEmail() -> String {
        if let check_string = NSUserDefaults.standardUserDefaults().stringForKey("userEmail") {
            return check_string
        } else {
            print("Cann't get user email from NSUserDefaults")
            return ""
        }
    }
    
    func setEmail(_email: String) {
        NSUserDefaults.standardUserDefaults().setObject(_email, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func setPassword(_password: String) {
        NSUserDefaults.standardUserDefaults().setObject(_password, forKey: "userPassword")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}