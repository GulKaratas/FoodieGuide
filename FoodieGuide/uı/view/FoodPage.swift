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
        navigationItem.hidesBackButton = true
        customizeTabBar()
        navigationTitle()
       
        let f = Food(id:1 ,name: "Pizza", image: "ottoman", price: 100)
        let f1 = Food(id:2 ,name: "Burger", image: "parfüm", price: 200)
        let f3 = Food(id:3 ,name: "Pasta", image: "saat", price: 300)
        let f4 = Food(id:4 ,name: "Salad", image: "telefon", price: 400)
        
        foodList.append(f)
        foodList.append(f1)
        foodList.append(f3)
        foodList.append(f4)
        
        let design = UICollectionViewFlowLayout()

        design.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10

       
        let screenWidth = UIScreen.main.bounds.width

       
        let itemWidth = (screenWidth - 50) / 3

        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        foodCollectionView.collectionViewLayout = design

        
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
        appearance.backgroundEffect = UIBlurEffect(style: .light) // Bulanık arka plan

        
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

extension FoodPage: UICollectionViewDataSource, UICollectionViewDelegate , CellProtocol{
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let food = foodList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        
        cell.foodImageView.image = UIImage(named: food.image!)
        cell.foodLabel.text = food.name
        cell.priceLabel.text = "\(food.price!)"
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
        
    }
    func addtoCart(indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        Shared.shared.items.append(food)
        
    }
    
}
