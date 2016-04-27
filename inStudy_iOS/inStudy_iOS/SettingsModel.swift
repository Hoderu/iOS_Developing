//
//  SettingsModel.swift
//  inStudy_iOS
//
//  Created by Андрей Решетников on 19.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit
import AFNetworking

protocol SettingsModelProtocol {
    func settingsDidLoaded()
}

class SettingsModel: NSObject {
    let apiURL: String!
    let logoutUrlTail: String!
    let emailParameterName: String!
    let passwordParameterName: String!
    var sessionManager: AFHTTPSessionManager!
    
    var delegate: SettingsModelProtocol?
    var alertShowDelegate: UIViewController?
    
    override init() {
        apiURL = "http://instudy.io:80/api/auth/"
        logoutUrlTail = "logout/"
        emailParameterName = "email"
        passwordParameterName = "password"
        sessionManager = AFHTTPSessionManager()
        sessionManager.requestSerializer = AFJSONRequestSerializer()
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        sessionManager.requestSerializer.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "Authorization")
        super.init()
    }
    
    func logout(email: String, password: String) {
        sessionManager.POST(apiURL + logoutUrlTail, parameters: [emailParameterName: email, passwordParameterName: password], progress: nil, success: { (sessionDataTask, response) in
            print("JSON response is \(response)")
            self.delegate?.settingsDidLoaded()
            }, failure: { (sessionDataTask, error) in
                print(error)
                Alert().showAlertMessage(self.alertShowDelegate!, alertTitle: "Ошибка!", alertMessage: "Ошибка на сервере")
                // TODO: specify error
        })
    }
}