//
//  AddCourseTuneViewController.swift
//  inStudy_iOS
//
//  Created by luba_yaronskaya on 23.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class AddCourseTuneViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameOfSettingLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var settingItem: String?
    var secondSettingItem: String?
    var settingName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        checkValidSettingValue()
        navigationItem.title = settingName
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidSettingValue()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidSettingValue() {
        // Disable the Save button if the text field is empty.
        let text = textField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            settingItem = textField.text ?? ""
            print("save");
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        let isPresentingInAddSettingMode = presentingViewController is UINavigationController
        
        if isPresentingInAddSettingMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    

}
