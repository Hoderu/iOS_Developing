//
//  TimeTableCell.swift
//  InStudyTimeTable
//
//  Created by Аксенов Сергей on 29.02.16.
//  Copyright © 2016 Аксенов Сергей. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var mark: Tag!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
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