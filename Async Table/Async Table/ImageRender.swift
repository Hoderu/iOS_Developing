//
//  ImageRender.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import Foundation
import UIKit

class ImageRender: ImageOperator {
    
    static var renderingQueue : NSOperationQueue! = NSOperationQueue()
    
    func renderImage(imageRecord : ImageRecord, targetSize : CGSize) {
        let renderingOperation : ImageRenderOperation = ImageRenderOperation(imageRecord: imageRecord, targetSize: targetSize)
        renderingOperation.completionBlock = {
            if (renderingOperation.cancelled) {
                return;
            }
            let mainQueue :NSOperationQueue! = NSOperationQueue.mainQueue()
            mainQueue.addOperationWithBlock { [weak self] in
                self?.delegate.fetchedImageRecord(imageRecord)
            }
        }
        ImageRender.pendingOperations[imageRecord.path] = renderingOperation
        ImageRender.renderingQueue.addOperation(renderingOperation)
    }
    
    func cancelRendering(path : String) {
        ImageRender.pendingOperations[path]?.cancel()
        ImageRender.pendingOperations.removeValueForKey(path)
    }
}
