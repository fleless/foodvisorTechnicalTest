//
//  Aliment.swift
//  foodvisor
//
//  Created by sayednasri on 16/01/2019.
//  Copyright © 2019 fahmi. All rights reserved.
//

import Foundation
class Aliment {
    var nom: String
    var calories: String
    var type: String
    var image: String
    
    init( nom: String, calories: String, type: String, image: String) {
        self.nom = nom
        self.calories = calories
        self.type = type
        self.image = image
    }
}
