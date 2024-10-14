import UIKit

class Details: UIViewController {

    var foodList: Food?
    var counter: Int = 0  // To track quantity
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let f = foodList {
            foodImageView.image = UIImage(named: f.image!)
            priceLabel.text = "\(f.price!) TL"
            nameLabel.text = f.name
        }
        
        // Initialize the numberLabel to 0
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
            
            if let existingItem = Shared.shared.item.first(where: { $0.name == foodList!.name }) {
                
                existingItem.quantity += counter
            } else {
                
                let newItem = Shared.CartItem(name: foodList!.name ?? "error", price: Double(Int(foodList!.price!)), quantity: counter, image: foodList?.image)
                Shared.shared.item.append(newItem)
            }
            
          
        }
    }
}
