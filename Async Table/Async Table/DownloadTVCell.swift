//
//  DownloadTVCell.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import Foundation
import UIKit

class DownloadTVCell: UITableViewCell, ImageOperationProtocol {
    @IBOutlet weak var testImageView: UIImageView!
    var imageDownloader : ImageDownloader!
    var imageRender : ImageRender!
    var imageRecord : ImageRecord!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.doSomethingWithAClosure{ [weak self]()->Void in
            self?.accessoryView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        //self.prepareForNewImage()
    }
    
    func startUpdatingCell(imagePath : String) {
        startDownloadingIndicators()
        self.doSomethingWithAClosure{ [weak self]()->Void in
            self?.imageDownloader = ImageDownloader(delegate: self)
            self?.imageRender = ImageRender(delegate: self)
            self?.imageRecord = ImageRecord(path: imagePath)
            self?.imageDownloader.downloadImageRecord(self!.imageRecord)
        }
    }
    
    func prepareForNewImage() {
        self.doSomethingWithAClosure{ [weak self]()->Void in
            if (self?.imageRecord.state == .Downloading) {
                self?.imageDownloader.cancelDownloading(self!.imageRecord.path)
            }
            self?.imageRecord.state = .NotDownloaded
            self?.testImageView.image = nil
            self?.imageRecord = nil
        }
    }
    func startDownloadingIndicators() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let indicator = self.accessoryView as! UIActivityIndicatorView
        indicator.startAnimating()
    }
    func stopDownloadingIndicators() {
        let indicator = self.accessoryView as! UIActivityIndicatorView
        indicator.stopAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    func doSomethingWithAClosure(closure: () -> Void) {
        closure()
    }
}

extension DownloadTVCell { //: ImageOperationProtocol {
    func fetchedImageRecord(imageRecord: ImageRecord) {
        self.doSomethingWithAClosure{ [weak self]()->Void in
            switch imageRecord.state {
            case .Downloaded :
                let width : CGFloat = self!.frame.width
                let height : CGFloat = self!.frame.height
                self?.imageRender.renderImage(imageRecord, targetSize: CGSize(width: width, height: height))
                break
            case .Rendered:
                self!.stopDownloadingIndicators()
                self!.testImageView.image = imageRecord.imageSmall
                if (self!.window?.rootViewController?.isKindOfClass(DownloadTVC) != nil) {
                    let parentVC : DownloadTVC = self!.window?.rootViewController as! DownloadTVC
                    let indexPath : NSIndexPath? = parentVC.tableView.indexPathForCell(self!)
                    if (indexPath != nil) {
                        DownloadTVC.downloadedImages[indexPath!] = imageRecord
                    }
                }
                break
            default :
                print("Error with fetching an image record")
            }
        }
    }
}