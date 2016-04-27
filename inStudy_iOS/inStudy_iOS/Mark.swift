//
//  Mark.swift
//  inStudy
//
//  Created by luba_yaronskaya on 27.02.16.
//  Copyright © 2016 MIPT. All rights reserved.
//

import UIKit

class Mark: UIView {
    
    // MARK: Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var mark = UIButton()
    var spacing: Int = 5
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let greenMarkImage = UIImage(named: "greenMark")
        
        let button = UIButton()
        button.setImage(greenMarkImage, forState: .Normal)
        mark = button
        addSubview(button)
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        buttonFrame.origin.x = CGFloat(0)
        mark.frame = buttonFrame
        updateButtonTypeStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = Int(frame.size.height)
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    
    func updateButtonTypeStates() {
        //TODO:
        //изменение цвета
    }
    
}
