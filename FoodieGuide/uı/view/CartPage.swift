import UIKit
import FirebaseAuth

class CartPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var foodCartTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        foodCartTableView.delegate = self
        foodCartTableView.dataSource = self
        foodCartTableView.separatorStyle = .none 
        
        setupLogoutButton()
        navigationTitle()
        updateBadgeValue()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        foodCartTableView.reloadData()
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
        logoutButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            if let homeVC = storyboard?.instantiateViewController(withIdentifier: "Home") {
                homeVC.modalPresentationStyle = .fullScreen
                present(homeVC, animated: true, completion: nil)
            }
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }

    func updateBadgeValue() {
        let totalItems = Shared.shared.item.reduce(0) { $0 + $1.quantity }
        if let tabBarItems = tabBarController?.tabBar.items {
            let cartItem = tabBarItems[2]
            cartItem.badgeValue = totalItems > 0 ? "\(totalItems)" : nil
        }
    }
    
    // Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shared.shared.item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell

        let cartItem = Shared.shared.item[indexPath.row]
        cell.nameLabel.text = cartItem.name

        let totalPrice = cartItem.price * Double(cartItem.quantity)
        cell.priceLabel.text = "\(totalPrice) TL"
        cell.adetLabel.text = "Adet: \(cartItem.quantity)"

        // Set the product image with rounded corners
        if let imageName = cartItem.image, let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageName)") {
            cell.foodImageView.kf.setImage(with: url)
        } else {
            cell.foodImageView.image = nil
        }
        
        // Styling each cell to appear like a card
        cell.foodImageView.layer.cornerRadius = 10
        cell.cellBackground.layer.cornerRadius = 20
        cell.cellBackground.layer.shadowColor = UIColor.black.cgColor
        cell.cellBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.cellBackground.layer.shadowOpacity = 0.1
        cell.cellBackground.layer.shadowRadius = 4
        cell.cellBackground.clipsToBounds = false
        
        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            Shared.shared.item.remove(at: indexPath.row)
            self.updateBadgeValue()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
