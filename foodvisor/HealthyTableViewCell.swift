//
//  HealthyTableViewCell.swift
//  foodvisor
//
//  Created by fahmi on 16/01/2019.
//  Copyright © 2019 fahmi. All rights reserved.
//

import UIKit

class HealthyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageEntree: UIImageView!
    @IBOutlet weak var nomEntree: UILabel!
    @IBOutlet weak var nbrCaloriesEntree: UILabel!
    @IBOutlet weak var imgPlat: UIImageView!
    @IBOutlet weak var nomPlat: UILabel!
    @IBOutlet weak var nbrCaloriesPlat: UILabel!
    @IBOutlet weak var imgDessert: UIImageView!
    @IBOutlet weak var nomDessert: UILabel!
    @IBOutlet weak var nbrCaloriesDessert: UILabel!
    @IBOutlet weak var nbrCaloriesTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
