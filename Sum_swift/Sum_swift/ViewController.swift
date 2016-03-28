//
//  ViewController.swift
//  Sum_swift
//
//  Created by Андрей Решетников on 18.02.16.
//  Copyright © 2016 mipt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var firstNumber: UITextField!
    
    @IBOutlet weak var secondNumber: UITextField!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBAction func multiply(sender: AnyObject) {
        if let a = Int(firstNumber.text!) {
            if let b = Int(secondNumber.text!) {
                userLabel.text = String(a + b)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

