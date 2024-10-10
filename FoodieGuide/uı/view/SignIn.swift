//
//  SignIn.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 9.10.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignIn: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    override func viewDidLoad() {
      
        super.viewDidLoad()

       
    }
    

    @IBAction func signInClicked(_ sender: Any) {
        if mailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) {  (auth, error) in
                if error != nil {
                    self.alertMessage(title: "Hata", message: error?.localizedDescription ?? "error")
                }else {
                    self.performSegue(withIdentifier: "toMainPage", sender: nil)
                }
            }
        }else {
            alertMessage(title: "Hata", message: "Boş bırakılan alanları doldurunuz")
        }
    }
    
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .destructive)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
