//
//  RegistrationViewController.swift
//  JarvisConsept
//
//  Created by Artem Krasko on 23.10.2024.
//
import UIKit

class RegistrationViewController: UIViewController {
    
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
        label.text = "Create a new account"
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
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account? Login", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#59499F")
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        // Додаємо containerView на екран
        view.addSubview(containerView)
        
        // Додаємо елементи до containerView
        containerView.addSubview(instructionLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(registerButton)
        containerView.addSubview(goToLoginButton)
        
        // Включаємо автоматичне управління обмеженнями
        containerView.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        goToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Додаємо обмеження для containerView
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 340),
            containerView.heightAnchor.constraint(equalToConstant: 400), // Встановлюємо висоту для containerView
            
            // Обмеження для instructionLabel
            instructionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            instructionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            instructionLabel.widthAnchor.constraint(equalToConstant: 300),
            
            // Обмеження для emailTextField
            emailTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            // Обмеження для passwordTextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            // Обмеження для registerButton
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Обмеження для goToLoginButton
            goToLoginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            goToLoginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        goToLoginButton.addTarget(self, action: #selector(goToLoginScreen), for: .touchUpInside)
    }
    
    @objc private func goToLoginScreen() {
        // Переходимо на екран авторизації
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
