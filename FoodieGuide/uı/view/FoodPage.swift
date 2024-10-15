//
//  FoodPage.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 11.10.2024.
//

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
        
        if searchBar == nil {
               print("searchBar is nil!")
           } else {
               searchBar.delegate = self
           }

        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        customizeTabBar()
        navigationTitle()

        _ = viewModel.foodList.subscribe(onNext: { Food in
            guard !Food.isEmpty else {
                print("Food verisi boş!")
                return
            }
            self.foodList = Food
            self.foodCollectionView.reloadData()
        })
        
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
          navigationItem.hidesBackButton = true
          
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

        
        cell.foodLabel.text = food.yemek_adi
        cell.priceLabel.text = " Fiyatı : \(food.yemek_fiyat!)"

        // Hücre için kenarlık ve köşe yuvarlama
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0
        
        

        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        
        // Resime tıklanabilirlik ekleme
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.foodImageView.isUserInteractionEnabled = true
        cell.foodImageView.addGestureRecognizer(tapGesture)
        tapGesture.view?.tag = indexPath.row  // Tıklanan resmin sırasını saklama

        cell.cellProtocol = self
        cell.indexPath = indexPath

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let destinationVC = segue.destination as? Details
            destinationVC?.food = sender as? Food
        }
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let index = sender.view!.tag
        let food = foodList[index]
        
        
        performSegue(withIdentifier: "toDetail", sender: food)
    }

   
    func addtoCart(indexPath: IndexPath) {
        let food = foodList[indexPath.row]
            
            
            if let existingItem = Shared.shared.item.first(where: { $0.name == food.yemek_adi }) {
                
                existingItem.quantity += 1
            } else {
               
                let price = Double(food.yemek_fiyat ?? "0") ?? 0.0
                
                
                let newItem = Shared.CartItem(name: food.yemek_adi ?? "error", price: price, quantity: 1, image: food.yemek_resim_adi ?? "default_image")
                Shared.shared.item.append(newItem)
           }

           
        print("\(food.yemek_adi) added to cart. Current quantity: \(Shared.shared.item.first(where: { $0.name == food.yemek_adi })?.quantity ?? 0)")
        
        
    }
}
extension FoodPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        
        
        if searchText.isEmpty {
            viewModel.foodList.subscribe(onNext: { Food in
                self.foodList = Food
                self.foodCollectionView.reloadData()
            }).dispose()
        } else {
            
            let filteredFoodList = foodList.filter { food in
                
                return food.yemek_adi?.contains(searchText) == true
            }
            self.foodList = filteredFoodList
            self.foodCollectionView.reloadData()
        }
    }
}
