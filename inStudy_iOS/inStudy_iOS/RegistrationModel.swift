//
//  RegistrationModel.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 07.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit
import AFNetworking

protocol RegistrationModelProtocol {
    func registrationDidLoaded()
}

class RegistrationModel: NSObject {
    let apiURL: String!
    
    let emailParameterName: String!
    let passwordParameterName: String!
    let loginUrlTail: String!
    let registerUrlTail: String!
    let firstNameParameterName: String!
    let secondNameParameterName: String!
    //
    
    // Хранение данных
    //
    
    var idCourseNews = [Dictionary<String, AnyObject>]()
    //
    
    // Менеджер загрузки
    var sessionManager: AFHTTPSessionManager!
    
    // Делегат
    var delegate: RegistrationModelProtocol?
    var alertShowDelegate: UIViewController?
    
    override init() {
        apiURL = "http://instudy.io:80/api/auth/"
        loginUrlTail = "login/"
        registerUrlTail = "register/"
        emailParameterName = "email"
        firstNameParameterName = "first_name"
        secondNameParameterName = "last_name"
        passwordParameterName = "password"
        sessionManager = AFHTTPSessionManager()
        sessionManager.requestSerializer = AFJSONRequestSerializer()
        //sessionManager.requestSerializer.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "Authorization")
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        super.init()
    }
    
    func login(email: String, password: String) {
        sessionManager.POST(apiURL + loginUrlTail, parameters: [emailParameterName: email, passwordParameterName: password], progress: nil, success: { (sessionDataTask, response) in
            print("JSON response is \(response)")
            GlobalStorage.token = (response as! Dictionary<String, AnyObject>)["auth_token"] as! String
            self.delegate?.registrationDidLoaded()
            }, failure: { (sessionDataTask, error) in
                print(error)
                Alert().showAlertMessage(self.alertShowDelegate!, alertTitle: "Ошибка!", alertMessage: "Неверный логин или пароль")
                // TODO: specify error
        })
    }
    
    func register(email: String, password: String) {
        sessionManager.POST(apiURL + registerUrlTail, parameters: [emailParameterName: email, firstNameParameterName: GlobalStorage.user!.firstName,
            secondNameParameterName: GlobalStorage.user!.secondName, passwordParameterName: password],
            progress: nil, success: { (sessionDataTask, response) in
            print("JSON response is \(response)")
            self.login(email, password: password)
            }, failure: { (sessionDataTask, error) in
                print(error)
                Alert().showAlertMessage(self.alertShowDelegate!, alertTitle: "Ошибка!", alertMessage: "Не удалось зарегистрироваться")
                // TODO: specify error
        })
    }
}
