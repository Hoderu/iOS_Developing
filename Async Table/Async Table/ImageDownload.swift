//
//  ImageDownload.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader: ImageOperator {
    
    static var downloadingQueue : NSOperationQueue! = NSOperationQueue()
    
    func downloadImageRecord(imageRecord : ImageRecord) {
        imageRecord.state = .Downloading
        let downloadingOperation : ImageDownloadingOperation = ImageDownloadingOperation(imageRecord: imageRecord)
        downloadingOperation.completionBlock = {
            if (downloadingOperation.cancelled) {
                return;
            }
            let mainQueue :NSOperationQueue! = NSOperationQueue.mainQueue()
            mainQueue.addOperationWithBlock { [weak self] in
                imageRecord.state = .Downloaded
                self?.delegate.fetchedImageRecord(imageRecord)
            }
        }
        ImageDownloader.pendingOperations[imageRecord.path] = downloadingOperation
        ImageDownloader.downloadingQueue.addOperation(downloadingOperation)
    }
    
    func cancelDownloading(path : String) {
        ImageDownloader.pendingOperations[path]?.cancel()
        ImageDownloader.pendingOperations.removeValueForKey(path)
    }
}
