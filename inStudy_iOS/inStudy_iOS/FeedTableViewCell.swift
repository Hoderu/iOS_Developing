//
//  FeedTableViewCell.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 06.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var answerTextLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var adTextLabel: UILabel!
    @IBOutlet weak var answerAuthorAvatarImage: UIImageView!
    /*var wallId: String!
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
