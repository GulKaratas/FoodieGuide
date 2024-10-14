//
//  Shared.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 11.10.2024.
//

import Foundation
class Shared {
    static let shared = Shared()
    var items = [Food]()
    
    var item: [CartItem] = []
    
    private init() {}
    
    class CartItem {
        var name: String
        var price: Double
        var quantity: Int
        var image: String?
        
        init(name: String, price: Double, quantity: Int, image: String?) {
            self.name = name
            self.price = price
            self.quantity = quantity
            self.image = image
        }
    }
}
