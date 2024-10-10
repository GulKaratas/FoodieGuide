//
//  Food.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import Foundation

class Food {
    
    var id: Int?
    var name: String?
    var image: String?
    var price: Int?
    
    init(){
        
    }
    init(id: Int, name: String , image: String, price: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
    }
    
}
