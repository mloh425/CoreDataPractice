//
//  HouseTableViewCell.swift
//  CoreDataPractice
//
//  Created by Sau Chung Loh on 10/21/16.
//  Copyright © 2016 Matthew Loh. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {

    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var houseLocationLabel: UILabel!
    @IBOutlet weak var houseMottoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
