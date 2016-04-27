//
//  AddControl.swift
//  inStudy
//
//  Created by luba_yaronskaya on 03.03.16.
//  Copyright © 2016 MIPT. All rights reserved.
//

import UIKit

class AddControl: UIView {
    // MARK: Properties
    
    var addImage = UIImageView()
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let icon = UIImage(named: "addIcon")
        
        addImage = UIImageView(image: icon)
        
        addSubview(addImage)
    }
    
    override func layoutSubviews() {
        let controlSize = Int(frame.size.width)
        var controlFrame = CGRect(x: 0, y:  Int(frame.size.height) - controlSize / 2, width: controlSize, height: controlSize)
        
        controlFrame.origin.x = CGFloat(0)
        addImage.frame = controlFrame
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.width)
        
        return CGSize(width: buttonSize, height: buttonSize)
    }
    
}

