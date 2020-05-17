//
//  FavoritesTableViewCell.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/15/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import UIKit
import Cosmos

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var myImg: UIImageView!
    
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myRate: CosmosView!
}
