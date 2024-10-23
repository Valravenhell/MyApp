import UIKit

class TabView: UIViewController {
    var ProfileViewController: UIViewController!
    var MenuViewController: UIViewController!
    var SettingViewController: UIViewController!
    var FavoriteViewController: UIViewController!

    private var underlineView: UIView! // Підкреслення
    private var customTabBarController: UITabBarController! // Замість tabBarController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ініціалізація контролерів
        ProfileViewController = JarvisConsept.ProfileViewController()
        
        // Створюємо навігаційний контролер для BurgerMenuViewController
        let burgerMenuVC = JarvisConsept.MenuViewController()
        let navController = UINavigationController(rootViewController: burgerMenuVC)
        FavoriteViewController = JarvisConsept.FavoriteViewController()
        MenuViewController = navController // Призначаємо навігаційний контролер
        
        SettingViewController = JarvisConsept.SettingViewController()
        
        // Налаштування tabBarItem для кожного контролера
        ProfileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        MenuViewController.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "circle"), tag: 1)
        SettingViewController.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 2)
        FavoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 3)
        
        // Зміщення заголовка та іконки вниз
        let titleAdjustment = UIOffset(horizontal: 0, vertical: 5) // Зміщення на 5 пунктів вниз
        ProfileViewController.tabBarItem.titlePositionAdjustment = titleAdjustment
        MenuViewController.tabBarItem.titlePositionAdjustment = titleAdjustment
        SettingViewController.tabBarItem.titlePositionAdjustment = titleAdjustment
        FavoriteViewController.tabBarItem.titlePositionAdjustment = titleAdjustment

        // Ініціалізація UITabBarController
        customTabBarController = UITabBarController()
        customTabBarController.viewControllers = [ProfileViewController, MenuViewController, SettingViewController, FavoriteViewController]
        customTabBarController.delegate = self // Додаємо делегат
        
        // Зміна кольору іконок та тексту tabBar
        customTabBarController.tabBar.tintColor = .black // Колір активних іконок
        customTabBarController.tabBar.unselectedItemTintColor = .black // Колір неактивних іконок

        // Додавання підкреслення під активну вкладку
        setupUnderlineView()
        
        // Налаштування обрамлення для tabBar
        addBorderToTabBar(tabBar: customTabBarController.tabBar)
        
        // Додавання вертикальних ліній для розділення елементів
        addSeparatorLines(to: customTabBarController.tabBar)

        // Встановлення rootViewController
        view.addSubview(customTabBarController.view)
        addChild(customTabBarController)
        customTabBarController.didMove(toParent: self)
    }
    
    private func setupUnderlineView() {
        guard let tabBarItems = customTabBarController.tabBar.items else { return }
        let tabBarItemCount = CGFloat(tabBarItems.count)
        let tabBarWidth = customTabBarController.tabBar.frame.width
        let tabBarItemWidth = tabBarWidth / tabBarItemCount

        // Початкове положення підкреслення під першим табом
        let underlineFrame = CGRect(
            x: (tabBarItemWidth - tabBarItemWidth * 0.8) / 1, // Центрування підкреслення під першим табом
            y: customTabBarController.tabBar.frame.height - -6, // Висота підкреслення
            width: tabBarItemWidth * 0.6, // Ширина підкреслення
            height: 2 // Висота підкреслення
        )
        
        underlineView = UIView(frame: underlineFrame)
        underlineView.backgroundColor = .black
        customTabBarController.tabBar.addSubview(underlineView)
    }

    private func moveUnderlineToTab(at index: Int, animated: Bool) {
        guard let tabBarItems = customTabBarController.tabBar.items else { return }
        let tabBarItemCount = CGFloat(tabBarItems.count)
        let tabBarWidth = customTabBarController.tabBar.frame.width
        let tabBarItemWidth = tabBarWidth / tabBarItemCount

        let newXPosition = (tabBarItemWidth * CGFloat(index)) + (tabBarItemWidth - tabBarItemWidth * 0.6) / 2 // Центруємо підкреслення

        // Зменшуємо висоту підкреслення і підіймаємо його ближче до іконок
        let underlineFrame = CGRect(
            x: newXPosition,
            y: customTabBarController.tabBar.frame.height - 27, // Зміщуємо вище під іконки
            width: tabBarItemWidth * 0.6, // Зменшуємо ширину, щоб вона була менша за кнопку
            height: 2 // Висота підкреслення
        )
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.underlineView.frame = underlineFrame
            }
        } else {
            underlineView.frame = underlineFrame
        }
    }

    private func addBorderToTabBar(tabBar: UITabBar) {
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor // Колір рамки
        border.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1) // Висота рамки
        tabBar.layer.addSublayer(border)
    }

    private func addSeparatorLines(to tabBar: UITabBar) {
        let separatorWidth: CGFloat = 1 // Ширина вертикальної лінії
        let separatorHeight: CGFloat = tabBar.frame.size.height - 20 // Висота вертикальної лінії (менше висоти tabBar)
        
        let numberOfSeparators = tabBar.items?.count ?? 0 - 1 // Кількість вертикальних ліній
        let tabBarItemWidth = tabBar.frame.size.width / CGFloat(tabBar.items?.count ?? 1)
        
        for i in 1...numberOfSeparators {
            let separator = CALayer()
            separator.backgroundColor = UIColor.black.cgColor // Колір розділювача
            separator.frame = CGRect(
                x: tabBarItemWidth * CGFloat(i),
                y: (tabBar.frame.size.height - separatorHeight) / 2, // Центруємо по вертикалі
                width: separatorWidth,
                height: separatorHeight
            )
            tabBar.layer.addSublayer(separator)
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension TabView: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Отримуємо індекс вибраної вкладки
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            moveUnderlineToTab(at: index, animated: true) // Анімація підкреслення
        }
    }
}

// MARK: - UIColor extension для ініціалізації кольору через HEX
extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // Якщо рядок починається з #, видаляємо його
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        // HEX повинен складатися з 6 символів
        guard hexString.count == 6 else {
            self.init(white: 0.0, alpha: 0.0) // прозорий колір при помилці
            return
        }

        // Розбираємо значення червоного, зеленого і синього
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
