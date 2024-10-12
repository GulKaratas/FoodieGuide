//
//  FoodCell.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import UIKit

protocol CellProtocol {
    func addtoCart(indexPath: IndexPath)
}

class FoodCell: UICollectionViewCell {
   
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    var cellProtocol: CellProtocol?
    var indexPath: IndexPath?
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBAction func plusButtonClicked(_ sender: Any) {
        cellProtocol?.addtoCart(indexPath: indexPath! )
        
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
    }
}
