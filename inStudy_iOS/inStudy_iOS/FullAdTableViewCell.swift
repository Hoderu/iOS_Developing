//
//  FullAdTableViewCell.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 14.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class FullAdTableViewCell: UITableViewCell {

    @IBOutlet weak var fullAdAvatarImageView: UIImageView!
    @IBOutlet weak var fullAdTitleLabel: UILabel!
    @IBOutlet weak var fullAdTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
