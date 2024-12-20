//
//  FoodPageViewModel.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import Foundation
import RxSwift

class FoodPageViewModel {

    var frepo = FoodDeoRepository()
    var foodList = BehaviorSubject<[Food]>(value: [Food]())
    
    init() {
        foodList = frepo.foodList
        foodInstall()
    }
    func foodInstall() {
        frepo.foodInstall()
    }
}
