import UIKit

class MyCustomTabBar: UITabBarController, UITabBarControllerDelegate {
    
    private let btnMiddle: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "TextColor")
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabItems()
        setupMiddleButton()
        configureTabBarAppearance()
    }

    private func setupMiddleButton() {
        btnMiddle.frame = CGRect(x: (tabBar.bounds.width / 2) - 30, y: -20, width: 60, height: 60)
        btnMiddle.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
        tabBar.addSubview(btnMiddle)
    }
    
    private func configureTabBarAppearance() {
        tabBar.tintColor = UIColor(named: "TextColor")
        let path = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        tabBar.layer.insertSublayer(shape, at: 0)
        
        // Tab bar öğe boyutu ve yerleşimi
        tabBar.itemWidth = 40
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 180
    }
    
    private func setupTabItems() {
        let foodPageVC = UINavigationController(rootViewController: FoodPage())
        let favoritesVC = UINavigationController(rootViewController: Favorites())
        setViewControllers([foodPageVC, favoritesVC], animated: false)
        
        guard let items = tabBar.items else { return }
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "heart.fill")
        
        // Seçili durumda tab bar öğelerinin rengi
        items[0].selectedImage = UIImage(systemName: "house.fill")?.withTintColor(UIColor(named: "TextColor")!, renderingMode: .alwaysOriginal)
        items[1].selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(UIColor(named: "TextColor")!, renderingMode: .alwaysOriginal)
    }
    
    @objc private func middleButtonTapped() {
        self.performSegue(withIdentifier: "toCart", sender: nil)
    }


    private func getPathForTabBar() -> UIBezierPath {
        let frameWidth = tabBar.bounds.width
        let frameHeight = tabBar.bounds.height + 20
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth / 2) - Int(holeWidth / 2)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole, y: 0))
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth / 3), y: holeHeight / 2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth / 3) / 8) * 6, y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth / 3) / 8) * 8, y: holeHeight / 2))
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2 * holeWidth) / 3, y: holeHeight / 2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth / 3) + (holeWidth / 3) / 3 * 2 / 5, y: (holeHeight / 2) * 6 / 4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth / 3) + (holeWidth / 3) / 3 * 2 + (holeWidth / 3) / 3 * 3 / 5, y: (holeHeight / 2) * 6 / 4))
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2 * holeWidth) / 3, y: holeHeight / 2), controlPoint2: CGPoint(x: leftXUntilHole + (2 * holeWidth) / 3 + (holeWidth / 3) * 2 / 8, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
        path.addLine(to: CGPoint(x: 0, y: frameHeight))
        path.close()
        
        return path
    }
}
