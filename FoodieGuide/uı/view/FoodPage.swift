import UIKit

class FoodPage: UIViewController {
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodList = [Food]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.hidesBackButton = true
        customizeTabBar()
        navigationTitle()
       
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

extension FoodPage: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let food = foodList[indexPath.row]
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        
        
       return cell
    }
    
    
    
}
