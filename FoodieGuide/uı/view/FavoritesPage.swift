//
//  FavoritesPage.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import UIKit

class FavoritesPage: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationItem.hidesBackButton = true // Geri butonunu gizle
          
      }
    
    func navigationTitle() {
        self.navigationItem.title = "Favorites"
        let color = UINavigationBarAppearance()

        color.backgroundColor = UIColor(named: "TextColor")
        color.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.standardAppearance = color
        navigationController?.navigationBar.compactAppearance = color
        navigationController?.navigationBar.scrollEdgeAppearance = color
    }
    

}
