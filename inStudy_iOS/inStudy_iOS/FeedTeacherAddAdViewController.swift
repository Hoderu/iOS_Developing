//
//  FeedTeacherAddAdViewController.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 12.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class FeedTeacherAddAdViewController: UIViewController, UITextViewDelegate  {
    @IBOutlet weak var adImportance: UISwitch!
    @IBOutlet weak var adTitle: UITextField!
    @IBOutlet weak var adText: UITextView!
    
    var feedModel: FeedModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        adText.delegate = self
        adText.text = "Текст объявления"
        adText.textColor = UIColor.lightGrayColor();
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var importance: Bool!
    var titleString: String!
    var textString: String = ""
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "doneTeacherSegue" {
            titleString = adTitle.text
            textString = adText.text
            importance = adImportance.on
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
            adText.text = "Текст объявления"
            adText.textColor = UIColor.lightGrayColor()
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
