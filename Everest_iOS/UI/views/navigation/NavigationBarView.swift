//
//  NavigationBarView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {
    var backButton = UIButton()
    var backButtonLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    func setup() {
        self.backgroundColor = self.superviewBackgroundColor
        
        backButtonLabel.text = "<"
        backButtonLabel.textAlignment = .center
        
        backButton.addSubview(backButtonLabel)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        backButton.backgroundColor = UIColor.red
        self.addSubview(backButton)
    }
    
    func didTapBackButton(sender: UIButton) {
        let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        backButtonLabel.topAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
        backButtonLabel.bottomAnchor.constraint(equalTo: backButton.bottomAnchor).isActive = true
        backButtonLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor).isActive = true
        backButtonLabel.trailingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
    }
}
