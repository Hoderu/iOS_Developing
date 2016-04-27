//
//  HTTPController.swift
//  inStudy_iOS
//
//  Created by Андрей Решетников on 06.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import Foundation

class HTTPController {
    
    init() {}
    
    func httpRequest(email: String, password: String, url: String, jsonString: String, token: String) -> Int {
        let request = NSMutableURLRequest(URL: (NSURL(string: url))!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if (token != "") {
            request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            GlobalStorage.token = jsonResult["auth_token"] as! String
        } catch let error as NSError {
            print(error.localizedDescription)
            return Int(1)
        }
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                print(response?.description)
            }
            print("HTTP response: \(httpResponse.statusCode)")
            return Int(0)
        } else {
            print("No HTTP response")
            return Int(1)
        }

    }
}