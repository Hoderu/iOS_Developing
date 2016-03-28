//
//  DownloadTVC.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import UIKit
import Foundation

enum ImageState {
    case NotDownloaded,
    Downloading,
    Downloaded,
    Rendering,
    Rendered,
    Failed
}

class ImageRecord {
    var path  : String
    var state : ImageState = .NotDownloaded
    var image : UIImage? = UIImage(named: "No image")
    var imageSmall : UIImage? = UIImage(named: "No big image")
    
    init() {
        self.path = ""
    }
    
    init(path : String) {
        self.path = path
    }
}

protocol ImageOperationProtocol {
    func fetchedImageRecord (imageRecord : ImageRecord)
}

class DownloadTVC: UITableViewController {
    
    var imagesLinks : [String] = []
    var imageDownloader : ImageDownloader!
    static var downloadedImages : [NSIndexPath : ImageRecord] = [NSIndexPath : ImageRecord]()
    
    func doSomethingWithAClosure(closure: () -> Void) {
        closure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("pictures", ofType: "txt")
        self.doSomethingWithAClosure{ [weak self]()->Void in
            self?.imagesLinks = (try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)).componentsSeparatedByString("\n")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesLinks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : DownloadTVCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DownloadTVCell
        if (DownloadTVC.downloadedImages[indexPath] == nil) {
            DownloadTVC.downloadedImages[indexPath] = cell.imageRecord
            self.doSomethingWithAClosure{ [weak self]()->Void in
                cell.startUpdatingCell(self!.imagesLinks[indexPath.row])
            }
        } else {
            cell.imageRecord = DownloadTVC.downloadedImages[indexPath]
            cell.testImageView.image = cell.imageRecord.imageSmall
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "showInFullScreenSegue") {
            let cell : DownloadTVCell = sender as! DownloadTVCell
            let destinationVC = segue.destinationViewController as! ViewController
            let indicator = cell.accessoryView as! UIActivityIndicatorView
            let imageView : UIImageView? = sender?.imageView
            if (imageView != nil) {
                imageView?.addSubview(indicator)
                destinationVC.imageRecord = cell.imageRecord
            }
        }
    }
    
}