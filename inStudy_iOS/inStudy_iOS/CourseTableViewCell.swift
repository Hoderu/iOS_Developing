//
//  CourseTableViewCell.swift
//  inStudy
//
//  Created by luba_yaronskaya on 27.02.16.
//  Copyright © 2016 MIPT. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var mark: Mark!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timetableLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}