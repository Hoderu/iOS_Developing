//
//  CommentModel.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 08.04.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

import UIKit
import AFNetworking

protocol CommentModelProtocol {
    func commentDidLoaded()
}

class CommentModel: NSObject {
    let apiURL: String!
    let textParameterName: String!
    
    var sessionManager: AFHTTPSessionManager!
    
    var delegate: CommentModelProtocol?
    var alertShowDelegate: UIViewController?
    
    override init() {
        apiURL = "http://instudy.io/api/feed/"
        textParameterName = "text"
        sessionManager = AFHTTPSessionManager()
        
        sessionManager.requestSerializer = AFJSONRequestSerializer() as AFJSONRequestSerializer
        sessionManager.requestSerializer.setValue("Token \(GlobalStorage.token)", forHTTPHeaderField: "Authorization")
        sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        super.init()
    }
    
    var idCommentDictionary : Array<Dictionary<String, AnyObject>>?
    
    func updateComments(wallId: String, postId: String) {
        sessionManager.GET(apiURL+wallId+"/"+postId+"/comments/", parameters: nil, progress: nil, success: { (sessionDataTask, response) in
            print("JSON response is \(response)")
            self.idCommentDictionary = response as? Array
            self.delegate?.commentDidLoaded()
            }, failure: { (sessionDataTask, error) in
                print(error)
                Alert().showAlertMessage(self.alertShowDelegate!, alertTitle: "Ошибка!", alertMessage: "Не удалось загрузить комментарии")
        })
    }
    
    func postComment(wallId: String, postId: String, text: String) {
        sessionManager.POST(apiURL+wallId+"/"+postId+"/comments/", parameters: [textParameterName: text], progress: nil, success: { (sessionDataTask, response) in
            print("JSON response is \(response)")
            self.updateComments(wallId, postId: postId)
            }, failure: { (sessionDataTask, error) in
                print(error)
                Alert().showAlertMessage(self.alertShowDelegate!, alertTitle: "Ошибка!", alertMessage: "Не удалось опубликовать комментарий")
        })
    }
}
