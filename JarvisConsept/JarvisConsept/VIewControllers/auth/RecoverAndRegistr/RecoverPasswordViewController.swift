import UIKit

class ForgotPasswordViewController: UIViewController {
    
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
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your email to reset your password"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Password", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.compact.backward"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#59499F")
        setupUI()
        setupActions() // Додаємо налаштування дій
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(instructionLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(resetButton)
        view.addSubview(arrowButton) // Додаємо кнопку на основний view
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 340),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            
            instructionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            instructionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            instructionLabel.widthAnchor.constraint(equalToConstant: 300),
            
            emailTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            resetButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: 200),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            
            arrowButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            arrowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupActions() {
        // Додаємо дії для кнопок
        arrowButton.addTarget(self, action: #selector(goToLoginScreen), for: .touchUpInside)
        // Якщо потрібно, додайте інші кнопки
    }
    
    @objc private func goToLoginScreen() {
        // Переходимо на екран авторизації
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
