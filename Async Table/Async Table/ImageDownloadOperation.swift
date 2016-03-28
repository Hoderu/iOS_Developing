//
//  ImageDownloadOperation.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadingOperation: NSOperation {
    
    let imageRecord : ImageRecord
    
    init (imageRecord : ImageRecord) {
        self.imageRecord = imageRecord
    }
    
    override func main() {
        self.doSomethingWithAClosure{ [weak self] () -> Void in
        if ((self?.cancelled) == nil) {
            return;
        }
        let imageData : NSData? = NSData(contentsOfURL: NSURL(string: self!.imageRecord.path)!)
        
        if ((self?.cancelled) != nil) {
            if (imageData != nil) {
                self?.imageRecord.image =  UIImage(data: imageData!)
                self?.imageRecord.state = ImageState.Downloaded
            } else {
                self?.imageRecord.image = nil
                self?.imageRecord.state = ImageState.Failed
            }
        }
        }
    }
    
    func doSomethingWithAClosure(closure: () -> Void) {
        closure()
    }
}
