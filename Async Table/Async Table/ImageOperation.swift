//
//  ImageOperation.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import UIKit
import Foundation

class ImageOperator: NSObject {
    
    let delegate : ImageOperationProtocol!
    static var pendingOperations : [String : NSOperation] = [String : NSOperation]()
    
    init (delegate : ImageOperationProtocol!) {
        self.delegate = delegate
    }
}