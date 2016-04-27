//
//  FeedModel.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 08.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit
import AFNetworking

protocol FeedModelProtocol {
    func feedDidLoaded()
    //func renewFeedModel(wallId: String)
}

class FeedModel: NSObject {
    let apiURL: String!
    
    let titleParameterName: String!
    let textParameterName: String!
    let typeParameterName: String!
    
    var wallId = ""
    
    var idCourseNews = [Dictionary<String, AnyObject>]()
    var idCourseNewsPrivate = [Dictionary<String, AnyObject>]()
    var idCourseNewsPublic = [Dictionary<String, AnyObject>]()
    
    var sessionManager: AFHTTPSessionManager!
    
    var delegate: FeedModelProtocol?
    var alertShowDelegate: UIViewController?
    
    override init() {
        apiURL = "http://instudy.io/api/feed/"
        titleParameterName = "title"
        textParameterName = "text"
        typeParameterName = "post_type"
        sessionManager = AFHTTPSessionManager()
        
        sessionManager.requestSerializer = AFJSONRequestSerializer() as AFJSONRequestSerializer
        sessionManager.requestSerializer.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "Authorization")
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        super.init()
    }
    
    convenience init(wallId: String) {
        self.init()
        self.wallId = wallId + "/"
    }
    
    func setCurrentWallId(wallId: String) {
        self.wallId = wallId + "/"
    }
    
    var singleCourseNews : Array<Dictionary<String, AnyObject>>?
    
    func newsDidLoaded(clearNews:Bool) {
        if clearNews {
            idCourseNews.removeAll()
            idCourseNewsPrivate.removeAll()
            idCourseNewsPublic.removeAll()
        }
        for singleNews in singleCourseNews! {
            if ((singleNews["is_public"] as! Bool)) {
                self.idCourseNewsPublic.append(singleNews)
            } else {
                self.idCourseNewsPrivate.append(singleNews)
            }
        }
        self.delegate?.feedDidLoaded()
        
    }
    
    func updateFeed() {
        sessionManager.GET(apiURL+wallId, parameters: nil, progress: nil, success: { (sessionDataTask, response) in
            print("JSON response is \(response)")
            self.singleCourseNews = response as? Array
            self.newsDidLoaded(true)
            }, failure: { (sessionDataTask, error) in
                print(error)
                Alert().showAlertMessage(self.alertShowDelegate!, alertTitle: "Ошибка!", alertMessage: "Не удалось загрузить ленту")
        })
    }
    
    func postNews(title: String, text: String, type: String) {
        sessionManager.POST(apiURL+wallId, parameters: ["anonymous": false, typeParameterName: "C", titleParameterName: title, textParameterName: text], progress: nil, success: { (sessionDataTask, response) in
            print("JSON response is \(response)")
            self.updateFeed()
            }, failure: { (sessionDataTask, error) in
                print(error)
                Alert().showAlertMessage(self.alertShowDelegate!, alertTitle: "Ошибка!", alertMessage: "Не удалось опубликовать новость")
        })
    }
    
}
