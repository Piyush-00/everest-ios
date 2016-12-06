//
//  BaseCameraSession.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-30.
//  Copyright © 2016 Everest. All rights reserved.
//
protocol BaseCameraSesssionProtocol {
  func didScanQRCode(response: String?)
}

import UIKit
import AVFoundation

class BaseCameraSesssion: UIView, AVCaptureMetadataOutputObjectsDelegate {
  
  private var captureSession: AVCaptureSession?
  private var previewLayerView: AVCaptureVideoPreviewLayer
  private var metaDataOutput: AVCaptureMetadataOutput
  
  var delegate: BaseCameraSesssionProtocol?
  
  init(_ coder: NSCoder? = nil){
    captureSession = AVCaptureSession()
    previewLayerView = AVCaptureVideoPreviewLayer()
    metaDataOutput = AVCaptureMetadataOutput()
    
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
    configureOutput()
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
  
  private func configureOutput() {
    if let captureSession = captureSession {
      if (captureSession.canAddOutput(metaDataOutput)) {
        captureSession.addOutput(metaDataOutput)
        metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        return
      }
    }
    failedSession()
  }
  
  //SKO - initialize qr code scanner
  func addOutput() {
    metaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
  }
  
  //SKO - remove qr code scanner
  func removeOutput() {
    metaDataOutput.metadataObjectTypes = nil
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
  
  //SKO - delegate method that gets fired when a qr code has been found
  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    removeOutput()
    //SKO - TODO: replace with HTTP class url parsing method to test integrity of url + handle modal display if url correct
    if let metadataObject = metadataObjects.first {
      if let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        print(readableObject.stringValue)
        delegate?.didScanQRCode(response: readableObject.stringValue!)
      }
    }
  }
}
