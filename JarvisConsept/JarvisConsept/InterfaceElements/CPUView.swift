//
//  CPUView.swift
//  JarvisConsept
//
//  Created by Artem Krasko on 11.04.2024.
//

import UIKit

class CPUView: UIView {
    
    var microchipImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMicrochipImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMicrochipImageView()
    }
    
    private func setupMicrochipImageView() {
        let microchipSize: CGFloat = 50.0
        microchipImageView = UIImageView(frame: CGRect(x: 175, y: 100, width: microchipSize, height: microchipSize))
        microchipImageView.image = UIImage(systemName: "cpu")
        microchipImageView.tintColor = UIColor(red: 34/255, green: 45/255, blue: 74/255, alpha: 1.0)
        microchipImageView.contentMode = .scaleAspectFit
        addSubview(microchipImageView)
    }
}

