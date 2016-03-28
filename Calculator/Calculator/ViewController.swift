//
//  ViewController.swift
//  Calculator
//
//  Created by Андрей Решетников on 27.01.16.
//  Copyright © 2016 mipt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!

    var userIsWritingANumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        if let digit = sender.currentTitle {
            if userIsWritingANumber {
                display.text = display.text! + digit
            } else {
                userIsWritingANumber = true
                display.text = digit
            }
            // print ("digit = \(digit)")
        }
    }
    
    @IBAction func operate(sender: AnyObject) {
        if userIsWritingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation!) {
                 displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsWritingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsWritingANumber = false
        }
    }
}

