//
//  CommentTableViewCell.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 14.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet var commentPostAnswerButton: UIButton!
    @IBOutlet weak var commentAuthorAvatarImageView: UIImageView!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    func isTeacher() -> Bool {
        return true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if (!isTeacher()) {
            commentPostAnswerButton.hidden = true
        }
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
