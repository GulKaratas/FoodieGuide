import UIKit
import FirebaseCore
import FirebaseAuth

class SignUp: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        if let email = mailTextField.text, let password = passwordTextField.text {
            
            
            if email.isEmpty || password.isEmpty {
                alertMessage(title: "Hata Mesajı", message: "Lütfen boş kısımları doldurunuz")
                return
            }
            
            if !isEmail(email) {
                alertMessage(title: "Hata Mesajı", message: "Geçerli bir e-posta adresi giriniz.")
                return
            }
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
                if let error = error {
                    
                    self.alertMessage(title: "Hata Mesajı", message: error.localizedDescription)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toSignIn", sender: nil)
                }
            }
        }
    }

    
    func isEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }

    
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .destructive)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
