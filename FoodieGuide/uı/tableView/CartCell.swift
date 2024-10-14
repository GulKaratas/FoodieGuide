//
//  CartCell.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 11.10.2024.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var cellBackground: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

   
}
