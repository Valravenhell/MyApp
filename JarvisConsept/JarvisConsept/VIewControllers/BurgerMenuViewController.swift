import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let sideMenuWidth: CGFloat = 300
    private var sideMenuView: UIView!
    private var isMenuOpen = false
    private let burgerButton = UIButton(type: .system)
    
    // Створюємо таблицю для бокового меню
    private let menuItems = ["Chats", "History", "QR-code", "Downloaded", "Logout"] // Дані для таблиці
    private var tableView: UITableView! // Таблиця для бокового меню
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBurgerButton()
        setupSideMenu()
        setupTableView() // Додаємо налаштування таблиці
        view.backgroundColor = UIColor(hex: "#59499F")
    }
    
    private func setupBurgerButton() {
        burgerButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        burgerButton.tintColor = .black
        burgerButton.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: burgerButton)
        navigationItem.leftBarButtonItem = barButtonItem  // Кнопка зліва
    }
    
    private func setupSideMenu() {
        let topSafeArea = view.safeAreaInsets.top
        let bottomSafeArea = view.safeAreaInsets.bottom
        let topInset: CGFloat = 50
        let bottomInset: CGFloat = 85
        let menuHeight = view.frame.height - topSafeArea - bottomSafeArea - topInset - bottomInset

        // Спочатку розміщуємо меню за межами екрана зліва
        sideMenuView = UIView(frame: CGRect(x: -sideMenuWidth, y: topSafeArea + topInset, width: sideMenuWidth, height: menuHeight))
        sideMenuView.backgroundColor = UIColor(hex: "#59400F")
        sideMenuView.layer.cornerRadius = 20
        view.addSubview(sideMenuView)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: sideMenuView.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none // Можна додати стиль роздільника, якщо потрібно
        sideMenuView.addSubview(tableView)
    }
    
    @objc private func toggleMenu() {
        isMenuOpen.toggle()
        
        // Рахуємо зсув з урахуванням того, чи відкрито меню
        let menuOffset = isMenuOpen ? sideMenuWidth : -sideMenuWidth

        // Анімація зміни іконки кнопки
        UIView.transition(with: burgerButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if self.isMenuOpen {
                self.burgerButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            } else {
                self.burgerButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
            }
            self.burgerButton.tintColor = .black

        }, completion: nil)
        
        // Анімація показу/сховання меню
        UIView.animate(withDuration: 0.3) {
            self.sideMenuView.frame.origin.x += menuOffset
        }
    }
    
    // MARK: - UITableViewDataSource Methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .black // Колір тексту
        cell.backgroundColor = .clear // Прозорий фон для клітинки
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        if selectedItem == "Logout" {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }
        print("Selected: \(menuItems[indexPath.row])")
        // Додайте тут обробку вибору елементу меню
    }
    
}
