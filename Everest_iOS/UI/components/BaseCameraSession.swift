//
//  BaseCameraSession.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-30.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import AVFoundation

class BaseCameraSesssion: UIView {
  
  private var captureSession: AVCaptureSession?
  private var previewLayerView: AVCaptureVideoPreviewLayer
  
  init(_ coder: NSCoder? = nil){
    
    captureSession = AVCaptureSession()
    previewLayerView = AVCaptureVideoPreviewLayer()
    
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    configureInput()
    configurePreviewLayer()
    self.layer.addSublayer(previewLayerView)
  }
  
  //SKU - Configure appropriate input sensors
  private func configureInput() {
    
    self.captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080

    let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    let videoInput: AVCaptureDeviceInput
    
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      //SKU - Remove the capture session and change the background colour of the view to black
      failedSession()
      return
    }
    
    if (self.captureSession?.canAddInput(videoInput))! {
      self.captureSession?.addInput(videoInput)
    } else {
      //SKU - Remove the capture session and change the background colour of the view to black
      failedSession()
      return
    }
  }
  
  private func configurePreviewLayer(){
    previewLayerView = AVCaptureVideoPreviewLayer(session: self.captureSession)
    previewLayerView.videoGravity = AVLayerVideoGravityResizeAspect
    previewLayerView.connection.videoOrientation = AVCaptureVideoOrientation.portrait
  }
  
  private func failedSession(){
    self.captureSession = nil
    backgroundColor = UIColor(hex: "#000000")
  }
  
  func startCameraSession(controller: UIViewController) {
    previewLayerView.frame = controller.view.frame
    captureSession?.startRunning()
  }
}
