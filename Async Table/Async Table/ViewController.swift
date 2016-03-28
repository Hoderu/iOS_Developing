//
//  ViewController.swift
//  Async Table
//
//  Created by Андрей Решетников on 03.06.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImageOperationProtocol {

    @IBOutlet weak var viewController: UIImageView!
    var imageRender : ImageRender!
    var imageRecord : ImageRecord!
    
    override func viewWillAppear(animated: Bool) {
        self.imageRender = ImageRender(delegate: self)
        self.imageRender.renderImage(imageRecord, targetSize: viewController.frame.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController { // : ImageOperationProtocol {
    func fetchedImageRecord(imageRecord: ImageRecord) {
        viewController.image = imageRecord.image
    }
}