//
//  FeedAddAdViewController.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 06.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class FeedAddAdViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var adTitle: UITextField!
    @IBOutlet weak var adText: UITextView!
    
    var feedModel: FeedModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        adText.delegate = self
        adText.text = "Введите ваш текст"
        adText.textColor = UIColor.lightGrayColor();
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var titleString: String!
    var textString: String = ""
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "doneSegue" {
            titleString = adTitle.text
            textString = adText.text
            //
            //feedModel.postNews()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if adText.textColor == UIColor.lightGrayColor() {
            adText.text = nil
            adText.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if adText.text.isEmpty {
            adText.text = "Введите ваш текст"
            adText.textColor = UIColor.lightGrayColor()
        }
    }
    
}
