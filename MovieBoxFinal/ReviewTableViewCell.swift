//
//  ReviewTableViewCell.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/14/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myAuthor: UILabel!
    @IBOutlet weak var myContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
