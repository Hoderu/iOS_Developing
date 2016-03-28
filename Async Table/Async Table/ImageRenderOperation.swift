//
//  ImageRenderOperation.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import Foundation
import UIKit

class ImageRenderOperation: NSOperation {
    
    let imageRecord : ImageRecord
    let targetSize : CGSize
    
    init (imageRecord : ImageRecord, targetSize : CGSize) {
        self.imageRecord = imageRecord
        self.targetSize = targetSize
    }
    
    func doSomethingWithAClosure(closure: () -> Void) {
        closure()
    }
    
    override func main() {
        self.doSomethingWithAClosure{ [weak self]()->Void in
        if (!self!.cancelled) {
            self!.imageRecord.state = .Rendering
            UIGraphicsBeginImageContextWithOptions(self!.targetSize, false, 0.0)
            self?.imageRecord.image?.drawInRect(CGRectMake(0, 0, self!.targetSize.width, self!.targetSize.height))
            let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self!.imageRecord.imageSmall = newImage
            self!.imageRecord.state = .Rendered
        }
        }
    }
}