import UIKit

class Details: UIViewController {

    var foodList: Food?
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Food nesnesinden alınan bilgileri ilgili UI öğelerine atıyoruz
        if let f = foodList {
            foodImageView.image = UIImage(named: f.image!) // Resmi ayarla
            numberLabel.text = String(f.id!)               // ID'yi göster
            priceLabel.text = "\(f.price!) TL"             // Fiyatı göster
            nameLabel.text = f.name                         // Yiyecek adını göster
        }
    }
    
    @IBAction func azaltButton(_ sender: Any) {
        // Azaltma işlemini burada tanımlayabilirsin
    }
    
    @IBAction func arttırButton(_ sender: Any) {
        // Arttırma işlemini burada tanımlayabilirsin
    }
}
