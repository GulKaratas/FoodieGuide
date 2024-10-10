//
//  CartPage.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import UIKit

class CartPage: UIViewController {

    @IBOutlet weak var foodCartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationTitle()
    }
    
    func navigationTitle() {
        self.navigationItem.title = "Foodie"
        let color = UINavigationBarAppearance()

        color.backgroundColor = UIColor(named: "TextColor")
        color.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.standardAppearance = color
        navigationController?.navigationBar.compactAppearance = color
        navigationController?.navigationBar.scrollEdgeAppearance = color
    }
   

}
