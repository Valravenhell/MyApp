import UIKit

class LoginViewController: UIViewController {
    
    // Функція для створення кнопки з однаковим стилем
    private func createButton(withTitle title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    // UI елементи
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to my App"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in to Continue"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail or ID"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 25
        textField.clipsToBounds = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.clipsToBounds = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    // Кнопки
    private lazy var loginButton: UIButton = createButton(withTitle: "Sign in", action: #selector(handleLogin))
    private lazy var forgotPasswordButton: UIButton = createButton(withTitle: "Forgot the password", action: #selector(handleForgotPassword))
    private lazy var registerButton: UIButton = createButton(withTitle: "Registration", action: #selector(handleRegister))
    
    // Контейнер (коробка)
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // Метод налаштування інтерфейсу
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#59499F")
        
        // Додаємо контейнер
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Додаємо елементи в контейнер
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(loginButton)
        containerView.addSubview(forgotPasswordButton)
        containerView.addSubview(registerButton)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Додаємо тайтли за межами контейнера
        view.addSubview(welcomeLabel)
        view.addSubview(subLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Розміщення контейнера і елементів
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 340),
            
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 300),
            
            registerButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 300),
            
            registerButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        if email == "test@example.com" && password == "password123" {
            navigateToTabView()
        } else {
            showAlert(message: "Invalid email or password")
        }
    }
    
    @objc private func handleForgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController()
            forgotPasswordVC.modalPresentationStyle = .fullScreen
            present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    @objc private func handleRegister() {
        let registrationVC = RegistrationViewController()
            registrationVC.modalPresentationStyle = .fullScreen
            present(registrationVC, animated: true, completion: nil)
    }
    
    private func navigateToTabView() {
        let tabBarController = TabView()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
