import UIKit
import FirebaseAuth

class CartPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var foodCartTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        foodCartTableView.delegate = self
        foodCartTableView.dataSource = self
        
        setupLogoutButton() // Call the function to set up the logout button
        navigationTitle()
        
        // Sepet iconunu güncelle
        updateBadgeValue()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true // Geri butonunu gizle
        foodCartTableView.reloadData() // Tablo verilerini güncelle
        
        // Sepet iconunu güncelle
        updateBadgeValue()
    }

    func navigationTitle() {
        self.navigationItem.title = "Sepet"
        let color = UINavigationBarAppearance()
        color.backgroundColor = UIColor(named: "TextColor")
        color.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = color
        navigationController?.navigationBar.compactAppearance = color
        navigationController?.navigationBar.scrollEdgeAppearance = color
    }
    
    func setupLogoutButton() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        logoutButton.tintColor = UIColor.white  // Set the button color
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logoutButtonTapped() {
        do {
            try Auth.auth().signOut() // Firebase'den çıkış yap
            
            // Ana sayfaya yönlendir
            if let homeVC = storyboard?.instantiateViewController(withIdentifier: "Home") {
                homeVC.modalPresentationStyle = .fullScreen
                present(homeVC, animated: true, completion: nil)
            }
            
        } catch {
            print("Çıkış işlemi başarısız: \(error.localizedDescription)")
        }
    }

    func updateBadgeValue() {
        let totalItems = Shared.shared.item.reduce(0) { $0 + $1.quantity } // Toplam ürün sayısını hesapla
        if let tabBarItems = tabBarController?.tabBar.items {
            let cartItem = tabBarItems[2] // İlk tab bar item'ı (sepet)
            cartItem.badgeValue = totalItems > 0 ? "\(totalItems)" : nil // Eğer sepet doluysa rozet değerini ayarla
        }
    }
    
    // Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shared.shared.item.count  // Number of items in the cart
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        
        // Get the corresponding cart item
        let cartItem = Shared.shared.item[indexPath.row]
        
        // Update the UI labels in the cell
        cell.nameLabel.text = cartItem.name
        cell.priceLabel.text = "\(cartItem.price) TL"
        cell.adetLabel.text = " Adet : \(cartItem.quantity)"  // Display the quantity
        
        if let imageName = cartItem.image {
            cell.foodImageView.image = UIImage(named: imageName)
        }
        
        cell.backgroundColor = UIColor(white: 0.95, alpha: 2)
        cell.cellBackground.layer.cornerRadius = 20.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                  // Remove item from shared item array
                  let itemToRemove = Shared.shared.item[indexPath.row]
                  Shared.shared.item.remove(at: indexPath.row)
                  
                  // Update badge value
                  self.updateBadgeValue()
                  
                  // Update table view
                  tableView.deleteRows(at: [indexPath], with: .automatic)
                  completionHandler(true) // Indicate that the action was handled
              }
              
              // Customize the delete action's appearance
              deleteAction.backgroundColor = .red
              
              // Create and return swipe actions configuration
              let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
              return configuration
          }
      }
