//
//  ImagePickerAlertController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-15.
//  Copyright © 2016 Everest. All rights reserved.
//
//SKU
/*
 Sample of how to use ImagePickerAlertController
 
 @IBAction func selectPhoto(_ sender: AnyObject) {
 
  let imagePicker = ImagePickerAlertController(frame: self.view.frame, controller: self)
  imagePicker.displayAlert(imageReference: imageView)
  imageView.contentMode = .scaleAspectFill
 
 }
 
*/

import UIKit

class ImagePickerAlertController: UIView, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

  var UIViewController : UIViewController?
  var alert : UIAlertController = UIAlertController()
  var imageReference: UIImageView = UIImageView()
  
  let imagePicker = UIImagePickerController()
  
  //SKU - When creating an Image picker controller, Object must be given its frame of reference as well as its UIViewController reference.
  init(frame: CGRect, controller: UIViewController){
    
    self.UIViewController = controller
    super.init(frame:frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    
    self.UIViewController = nil
    super.init(coder: aDecoder)
  }
  
  //SKU - To fire any events associated with images, an UIImageView reference must be given.
  public func displayAlert(imageReference: UIImageView){
    self.imageReference = imageReference
    
    //SKU - Setting up the pop up to allow users to either select images from the gallery or take a new photo
    self.alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let galleryAction = UIAlertAction(title: "Choose Photo",style:.default, handler:handleGalleryAction)
    let cameraAction = UIAlertAction(title: "Take Photo",style:.default, handler:handleCameraAction)
    let cancelAction = UIAlertAction(title: "Cancel",style:.cancel) {action -> Void in }
    
    self.alert.addAction(cancelAction)
    self.alert.addAction(cameraAction)
    self.alert.addAction(galleryAction)
    
    //SKU - Show the popup
    self.UIViewController?.present(alert,animated:true,completion:nil)
  }
  
  func handleGalleryAction(alertAction:UIAlertAction!){
    //SKU - Once an option has been selected, we want to make sure to clean up our modals as we go
    self.alert.dismiss(animated:true,completion:nil)
    self.browseGallery()
  }

  func handleCameraAction(alertAction:UIAlertAction!){
    //SKU - Once an option has been selected, we want to make sure to clean up our modals as we go
    self.alert.dismiss(animated:true,completion:nil)
    self.takePicture()
  }
  
  func browseGallery() {
    //SKU - Check if we have valid access, If not, present user with appropriate response
    if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
      self.imagePicker.sourceType = .photoLibrary
      self.imagePicker.allowsEditing = false
      self.imagePicker.delegate = self
      self.UIViewController?.present(imagePicker, animated: true, completion: nil)
      
    }
    else{
      postAlert(title: "Gallery inaccessable", message: "Application cannot access the photo library")
    }
    
  }
  
  
  func takePicture() {
    //SKU - Check if we have valid access, If not, present user with appropriate response
    if (UIImagePickerController.isSourceTypeAvailable(.camera)){
      if UIImagePickerController.availableCaptureModes(for: .rear) != nil || UIImagePickerController.availableCaptureModes(for: .front) != nil{
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .camera
        self.imagePicker.cameraCaptureMode = .photo
        self.imagePicker.delegate = self
        self.UIViewController?.present(imagePicker, animated: true, completion: nil)
      }
      else {
        postAlert(title: "Rear camera doesn't exist",message:"Application cannot access the camera.")
      }
    }
    else {
      postAlert(title: "Camera inaccessable",message:"Application cannot access the camera.")
    }
  }
  
  //SKU - Completion handlers that are built in with UIImagePickerControllerDelegate. Allow user to select photo and display the image in the corresponding UIImageView
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let chosenImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
      if (picker.sourceType == .camera){
        UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil)
      }
      self.imageReference.image = chosenImage
    }
    self.imagePicker.dismiss(animated: true,completion: nil)

  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.UIViewController?.dismiss(animated: true, completion: nil)
  }

  //SKU - Helper function for presenting error messages.
  private func postAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    self.UIViewController?.present(alert, animated: true, completion: nil)
  }
  
}
