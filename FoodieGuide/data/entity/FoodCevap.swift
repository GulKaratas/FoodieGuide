//
//  FoodAnswer.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import Foundation

class FoodCevap: Codable {
    var yemekler: [Food]?  // JSON'da "yemekler" ile eşleşiyor
    var success: Int?      // JSON'daki "success" ile eşleşiyor
}
