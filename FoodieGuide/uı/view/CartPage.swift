import UIKit

class CartPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var foodCartTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        foodCartTableView.delegate = self
        foodCartTableView.dataSource = self
        
      

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        foodCartTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shared.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        
        let food = Shared.shared.items[indexPath.row]
        cell.nameLabel.text = food.name
        cell.priceLabel.text = "\(food.price!) TL"
        cell.foodImageView.image = UIImage(named: food.image!)
        cell.backgroundColor = UIColor(white: 0.95, alpha: 2)
        cell.cellBackground.layer.cornerRadius = 20.0
        return cell
    }

}
