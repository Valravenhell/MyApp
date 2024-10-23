//
//  KeyboardView.swift
//  JarvisConsept
//
//  Created by Artem Krasko on 14.04.2024.
//

import UIKit

class KeyboardView: UIView {
    var searchTextField: UITextField!
    var voiceInputButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupKeyboard()
    }
    
    private func setupKeyboard() {
        // Search text field
        searchTextField = UITextField(frame: CGRect(x: 10, y: 0, width: frame.width - 80, height: frame.height))
        searchTextField.placeholder = "Search"
        searchTextField.backgroundColor = .white
        searchTextField.layer.cornerRadius = 5
        addSubview(searchTextField)
        
        // Voice input button
        voiceInputButton = UIButton(type: .system)
        voiceInputButton.setTitle("Voice Input", for: .normal)
        voiceInputButton.frame = CGRect(x: frame.width - 70, y: 0, width: 60, height: frame.height)
        addSubview(voiceInputButton)
    }
}
