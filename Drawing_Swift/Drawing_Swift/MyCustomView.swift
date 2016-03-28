//
//  MyCustomView.swift
//  Drawing_Swift
//
//  Created by Андрей Решетников on 25.04.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import UIKit

@IBDesignable

class MyCustomView: UIView {
    @IBInspectable var lineWidth: CGFloat = 1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineColor:
        UIColor = UIColor.blackColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        UIColor.blackColor().setStroke()
        /*let bezierPath = UIBezierPath()
        
        //let endPoint = CGPoint(x: self.bounds.width - 10, y: self.bounds.height - 10)
        //bezierPath.addLineToPoint(endPoint)
        
        let first = CGPoint(x: 30, y: 30)
        let second = CGPoint(x: 90, y: 300)
        let third = CGPoint(x: 180, y: 150)
        
        bezierPath.moveToPoint(first)
        bezierPath.addLineToPoint(second)
        bezierPath.addLineToPoint(third)
        bezierPath.addLineToPoint(first)
        
        bezierPath.lineWidth = self.lineWidth
        bezierPath.stroke()*/
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let startAngle: CGFloat = 3 * 3.14 / 4
        let endAngle: CGFloat = 3.14 / 4
        
        let path = UIBezierPath(arcCenter: center,
            radius: radius/2 - self.lineWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        path.lineWidth = self.lineWidth
        path.stroke()
        
    }

}