//
//  STCamera+Configurations.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import AVFoundation

class QRController : STUIViewController,IQRCode ,AVCaptureMetadataOutputObjectsDelegate{
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
override func viewDidLoad() {
        super.viewDidLoad()
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined: requestCameraPermission()
        case .authorized: presentCamera()
        case .restricted: alertCameraAccessNeeded()
        case .denied: alertCameraAccessNeeded()
        }
    }
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else {
                self.dismiss(animated: true, completion: nil)
                return
            }
            self.presentCamera()
        })
    }
    
    func presentCamera() {
        fatalError("Must be override in sub class")
    }
    
    func alertCameraAccessNeeded() {
        
//        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this feature.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
//            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
