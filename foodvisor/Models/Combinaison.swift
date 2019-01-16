//
//  Combinaison.swift
//  foodvisor
//
//  Created by fahmi on 16/01/2019.
//  Copyright © 2019 fahmi. All rights reserved.
//

import Foundation
class Combinaison {
    var entree: Aliment
    var plat: Aliment
    var dessert: Aliment
    var sumCal: Int
    
    init(entree: Aliment, plat: Aliment, dessert: Aliment, sumCal: Int) {
        self.entree = entree
        self.plat = plat
        self.dessert = dessert
        self.sumCal = sumCal
    }
}
