//
//  NavigationBarView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

/*SKO
 Navigation bar that contains a back button that pops the user
 to the preceding screen when clicked.
*/
class NavigationBarView: UIView {
    var backButton = UIButton()
    var backButtonLabel = UILabel()
    private var height: CGFloat = 60.0
    
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
        
        backButtonLabel.text = "Back"
        backButtonLabel.textAlignment = .left
        backButtonLabel.textColor = AppStyle.sharedInstance.textColor
        backButtonLabel.font = AppStyle.sharedInstance.headerFontMedium
      
        backButton.addSubview(backButtonLabel)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        self.addSubview(backButton)
    }
    
    @objc func didTapBackButton(sender: UIButton) {
        if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
            navigationController.popViewController(withAnimation: navigationController.getPopAnimationType())
        }
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        backButtonLabel.topAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
        backButtonLabel.bottomAnchor.constraint(equalTo: backButton.bottomAnchor).isActive = true
        backButtonLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor, constant: 5).isActive = true
        backButtonLabel.trailingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
    }
    
    func getHeight() -> CGFloat {
        return height
    }
}
