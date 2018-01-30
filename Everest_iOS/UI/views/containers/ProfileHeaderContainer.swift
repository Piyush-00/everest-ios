//
//  ProfileHeaderContainer.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-22.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class ProfileHeaderContainer: UIView, ImagePickerAlertProtocol {
    var controller: UIViewController?
    var pictureImageView: UIImageView
    private var imageSize: CGFloat

    init(_ pictureSize: CGFloat = 100, controller: UIViewController? = nil, coder: NSCoder? = nil) {
        self.controller = controller
        pictureImageView = UIImageView()
        imageSize = pictureSize

        if let coder = coder {
          super.init(coder: coder)!
        } else {
          super.init(frame: CGRect.zero)
        }
        
        pictureImageView.layer.borderWidth = 1
        pictureImageView.layer.backgroundColor = AppStyle.sharedInstance.pictureImageViewBorderColor.cgColor
        pictureImageView.image = AppStyle.sharedInstance.pictureImage

        addSubview(pictureImageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        pictureImageView.isUserInteractionEnabled = true
        pictureImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    required convenience init(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        self.pictureImageView.translatesAutoresizingMaskIntoConstraints = false

        self.pictureImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.pictureImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.pictureImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        self.pictureImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        self.pictureImageView.layer.cornerRadius = imageSize/2
        self.pictureImageView.clipsToBounds = true
        self.pictureImageView.contentMode = .scaleAspectFill
        self.pictureImageView.layer.masksToBounds = true
    }

    func getPictureSize() -> CGFloat{
        return imageSize
    }

    func setPictureBorder(borderWidth: CGFloat = 1, borderColor: UIColor = UIColor(netHex: 0x000000)){
        self.pictureImageView.layer.borderWidth = borderWidth
        self.pictureImageView.layer.borderColor = borderColor.cgColor
    }
    
    func setControllerForImagePicker(controller: UIViewController) {
        self.controller = controller
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        if controller != nil {
            let imagePicker = ImagePickerAlertController(frame: UIScreen.main.bounds, controller: controller!)
            imagePicker.displayAlert()
            imagePicker.delegate = self
        }
    }
  
  //MARK: ImagePickerAlertProtocol
  
  func didPickImage(image: UIImage) {
    pictureImageView.image = image
  }
}
