//
//  DeletedClassTableViewCell.swift
//  inStudy
//
//  Created by luba_yaronskaya on 03.03.16.
//  Copyright © 2016 MIPT. All rights reserved.
//

import UIKit

class DeletedCourseTableViewCell: UITableViewCell {
    // MARK: Properties

    @IBOutlet weak var timetableLabel: UILabel!
    @IBOutlet weak var mark: Mark!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

