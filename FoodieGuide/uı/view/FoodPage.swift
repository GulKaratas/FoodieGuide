import UIKit
import Kingfisher

class FoodPage: UIViewController {

    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var viewModel = FoodPageViewModel()

    var foodList = [Food]()
    override func viewDidLoad() {
        super.viewDidLoad()

        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self

        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        customizeTabBar()
        navigationTitle()

        // Örnek veri ekleme
        let f = Food(id:1 ,name: "Pizza", image: "ottoman", price: 100)
        let f1 = Food(id:2 ,name: "Burger", image: "parfüm", price: 200)
        let f3 = Food(id:3 ,name: "Pasta", image: "saat", price: 300)
        let f4 = Food(id:4 ,name: "Salad", image: "telefon", price: 400)

        foodList.append(f)
        foodList.append(f1)
        foodList.append(f3)
        foodList.append(f4)

        // Koleksiyon görünümünün tasarımını ayarlama
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 1
        design.minimumLineSpacing = 10

        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2

        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        foodCollectionView.collectionViewLayout = design
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationItem.hidesBackButton = true // Geri butonunu gizle
          
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

    private func customizeTabBar() {
        guard let tabBar = tabBarController?.tabBar else { return }

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = UIColor.lightGray
        appearance.shadowImage = UIImage()

        let itemAppearance = UITabBarItemAppearance()
        configureItemAppearance(itemAppearance)

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance

        appearance.configureWithOpaqueBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .light)

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        tabBar.layer.cornerRadius = 20
        tabBar.clipsToBounds = true
    }

    private func configureItemAppearance(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.selected.iconColor = UIColor(named: "TextColor") ?? UIColor.black
        itemAppearance.normal.iconColor = UIColor.systemGray
    }
}

extension FoodPage: UICollectionViewDataSource, UICollectionViewDelegate, CellProtocol {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = foodList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell

        cell.foodImageView.image = UIImage(named: food.image!)
        cell.foodLabel.text = food.name
        cell.priceLabel.text = "\(food.price!)"

        // Hücre için kenarlık ve köşe yuvarlama
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0

        // Resime tıklanabilirlik ekleme
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.foodImageView.isUserInteractionEnabled = true
        cell.foodImageView.addGestureRecognizer(tapGesture)
        tapGesture.view?.tag = indexPath.row  // Tıklanan resmin sırasını saklama

        cell.cellProtocol = self
        cell.indexPath = indexPath

        return cell
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let index = sender.view!.tag
        let food = foodList[index]
        
        // Resim tıklandığında yapılacak işlem
        performSegue(withIdentifier: "toDetail", sender: food)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let destinationVC = segue.destination as? Details {
                if let selectedFood = sender as? Food {
                    destinationVC.foodList = selectedFood
                    
                }
            }
        }
    }

    func addtoCart(indexPath: IndexPath) {
        let food = foodList[indexPath.row]

           // Check if the item already exists in the cart
           if let existingItem = Shared.shared.item.first(where: { $0.name == food.name }) {
               // If the item exists, increase the quantity
               existingItem.quantity += 1
           } else {
               // If the item is not in the cart, add it with a quantity of 1
               let price = Double(food.price ?? 0)  // Provide a default value of 0 if the price is nil
                  
                  // If the item is not in the cart, add it with a quantity of 1
                  let newItem = Shared.CartItem(name: food.name ?? "error", price: price, quantity: 1, image: food.image)
                  Shared.shared.item.append(newItem)
           }

           
           print("\(food.name) added to cart. Current quantity: \(Shared.shared.item.first(where: { $0.name == food.name })?.quantity ?? 0)")
        
        
    }
}
