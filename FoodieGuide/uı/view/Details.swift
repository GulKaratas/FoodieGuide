import UIKit
import Kingfisher

class Details: UIViewController {
    
    var foodList: [Food]?
    var counter: Int = 0
    var food : Food?
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let food = food {
                print("Food verisi: \(food)")
                if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
                    DispatchQueue.main.async {
                        self.foodImageView.kf.setImage(with: url)
                    }
                }
                priceLabel.text = "Fiyatı : \(food.yemek_fiyat!) TL"
                nameLabel.text = food.yemek_adi
            } else {
                print("Food verisi gelmedi.")
            }
       
        numberLabel.text = "\(counter)"
    }
    
   
    @IBAction func azaltButton(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            numberLabel.text = "\(counter)"
        }
    }
    
    
    @IBAction func arttırButton(_ sender: Any) {
        counter += 1
        numberLabel.text = "\(counter)"
    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        
        if counter > 0 {
                if let food = food {
                    if let existingItem = Shared.shared.item.first(where: { $0.name == food.yemek_adi }) {
                        existingItem.quantity += counter
                    } else {
                        
                        if let fiyat = Double(food.yemek_fiyat ?? "0") {
                            
                            let newItem = Shared.CartItem(
                                name: food.yemek_adi ?? "error",
                                price: fiyat,
                                quantity: counter,
                                image: food.yemek_resim_adi
                            )
                            Shared.shared.item.append(newItem)
                        }
                    }
                    
                    showAlert(message: "Sepete eklendi!")
                }
            } else {
                
                showAlert(message: "Lütfen miktarı artırın.")
            }
        }

        func showAlert(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
}
