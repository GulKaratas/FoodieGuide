//
//  Details.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 11.10.2024.
//

import UIKit

class Details: UIViewController {

    var foodList : Food?
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let f = foodList {
            foodImageView.image = UIImage(named: f.image!)
            numberLabel.text = String(f.id!)
            priceLabel.text = String(f.price!)
            nameLabel.text = f.name
        }
        
    }
    

   
    @IBAction func azaltButton(_ sender: Any) {
    }
    
    @IBAction func arttırButton(_ sender: Any) {
    }
}
