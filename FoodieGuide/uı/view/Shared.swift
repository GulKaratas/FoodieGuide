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
    
    private init() {} 
}
