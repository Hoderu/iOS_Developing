//
//  FeedType3TableViewCell.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 12.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class FeedType3TableViewCell: UITableViewCell {

    @IBOutlet weak var avatarType3ImageView: UIImageView!
    @IBOutlet weak var adTextType3Label: UILabel!
    @IBOutlet weak var adTitleType3Label: UILabel!
    /*
    var wallId: String!
    var delegate: FeedModelProtocol?
    
    @IBAction func courseButtonTapped(sender: UIButton) {
        // Use delegates
        self.delegate?.renewFeedModel(wallId)
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
