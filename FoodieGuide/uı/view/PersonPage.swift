//
//  PersonPage.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import UIKit
import Firebase
import FirebaseAuth
class PersonPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationTitle()
    }
    
    @IBAction func signOutClicked(_ sender: Any) {
        do {
             try Auth.auth().signOut()
            self.performSegue(withIdentifier: "signOut", sender: nil)
        } catch {
            print("error")
        }
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
