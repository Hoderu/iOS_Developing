//
//  Mark.swift
//  InStudyTimeTable
//
//  Created by Аксенов Сергей on 05.03.16.
//  Copyright © 2016 Аксенов Сергей. All rights reserved.

import UIKit

class Tag: UIView {
    
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    
    var mark = UIButton()
    var spacing: Int = 5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /*let greenMarkImage = UIImage(named: "greenMark")
        
        let button = UIButton()
        button.setImage(greenMarkImage, forState: .Normal)
        mark = button
        addSubview(button)*/
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        buttonFrame.origin.x = CGFloat(0)
        mark.frame = buttonFrame
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = Int(frame.size.height)
        
        return CGSize(width: width, height: buttonSize)
    }
    
    func setColorAccordingToTime(classTimeStr : String)
    {
        let inFormatter = NSDateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        inFormatter.dateFormat = "HH:mm"
        let classTime = inFormatter.dateFromString(classTimeStr)!
        
        let currentTime = NSDate()
        print(inFormatter.stringFromDate(classTime))
        if (currentTime.compare(classTime) == NSComparisonResult.OrderedDescending)
        {
            let redMarkImage = UIImage(named: "RedMark")
            let button = UIButton()
            button.setImage(redMarkImage, forState: .Normal)
            mark = button
            addSubview(button)
        }
        else
        {
            let greenMarkImage = UIImage(named: "GreenMark")
            let button = UIButton()
            button.setImage(greenMarkImage, forState: .Normal)
            mark = button
            addSubview(button)
        }
        /*var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var DateInFormat:String = dateFormatter.stringFromDate()*/
    }
    
}