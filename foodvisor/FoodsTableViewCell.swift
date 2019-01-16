//
//  FoodsTableViewCell.swift
//  foodvisor
//
//  Created by sayednasri on 16/01/2019.
//  Copyright © 2019 fahmi. All rights reserved.
//

import UIKit

class FoodsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var nomFood: UILabel!
    @IBOutlet weak var nbrCalories: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
