import UIKit
import Kingfisher

class Details: UIViewController {
    
    var foodList: [Food]?  // Food listesi dizi olarak tanımlandı
    var counter: Int = 0  // Miktarı takip etmek için counter
    var viewModel = DetailsViewModel()
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewModel'den gelen veriyi dinliyoruz ve UI'ı güncelliyoruz
        _ = viewModel.foodList.subscribe(onNext: { foodArray in
            self.foodList = foodArray
            // Eğer birden fazla yemek varsa, ilkini gösterelim
            if let firstFood = foodArray.first {
                self.updateUI(with: firstFood)
            }
        })
        
        // Varsayılan olarak miktarı sıfırlıyoruz
        numberLabel.text = "\(counter)"
    }
    
    // UI'ı güncellemek için fonksiyon
    func updateUI(with food: Food) {
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                self.foodImageView.kf.setImage(with: url)
            }
        }
        priceLabel.text = "Fiyatı : \(food.yemek_fiyat!) TL"
        nameLabel.text = food.yemek_adi
    }
    
    // Miktarı azaltma fonksiyonu
    @IBAction func azaltButton(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            numberLabel.text = "\(counter)"
        }
    }
    
    // Miktarı artırma fonksiyonu
    @IBAction func arttırButton(_ sender: Any) {
        counter += 1
        numberLabel.text = "\(counter)"
    }
    
    // Sepete ekleme fonksiyonu
    @IBAction func addToCart(_ sender: Any) {
        // Miktar sıfırdan büyükse sepete ekleme işlemi yapılır
        if counter > 0 {
            if let food = foodList?.first { // İlk yemeği alıyoruz
                // Sepette zaten mevcutsa miktarı artır
                if let existingItem = Shared.shared.item.first(where: { $0.name == food.yemek_adi }) {
                    existingItem.quantity += counter
                } else {
                    // Yemek fiyatı string olduğu için önce double'a dönüştürüyoruz
                    if let fiyat = Double(food.yemek_fiyat ?? "0") {
                        // Sepette yoksa yeni bir öğe olarak ekle
                        let newItem = Shared.CartItem(
                            name: food.yemek_adi ?? "error",
                            price: fiyat,  // Yemek fiyatını al ve double olarak kullan
                            quantity: counter,
                            image: food.yemek_resim_adi
                        )
                        Shared.shared.item.append(newItem)
                    }
                }
            }
        }
    }
}
