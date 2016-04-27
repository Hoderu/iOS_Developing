//
//  FullPostedAdTableViewCell.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 16.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class FullPostedAdTableViewCell: UITableViewCell {

    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var answerTextLabel: UILabel!
    @IBOutlet weak var answerAuthorImageView: UIImageView!
    @IBOutlet weak var postAuthorAvatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
