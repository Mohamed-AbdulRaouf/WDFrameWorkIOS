//
//  QRcodeViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import AVFoundation
//import DAL
public class QRcodeViewController: QRController,IBaseController{
    
    // MARK: - Properties
    public typealias T = IQRViewModel
    public var viewModel: IQRViewModel?
    let supportedBarCodes = [AVMetadataObject.ObjectType.qr]

    // MARK: - IBOutlets
    @IBOutlet weak var rewardTitleLabel: UILabel!
    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var qrMessageTitle: UILabel!
    var sourceDelegate: ISplashViewController?
    var onDismissQRVC: ((Bool) -> Void)?
    @IBOutlet weak var skiptBtn: UIButton!
    
    // MARK: - View Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.setupLabel()
        self.bindingData()
    }
    
     open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = R.string.localizable.scan_earn()
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Functions
    public override func presentCamera()  {
        DispatchQueue.main.async {
            self.captureSession = AVCaptureSession()
            guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
            guard let input = try? AVCaptureDeviceInput(device: captureDevice), self.captureSession!.canAddInput(input)
                else { return }
            
            self.captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            self.captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = self.supportedBarCodes
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
            self.videoPreviewLayer?.borderColor = UIColor.red.cgColor
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resize
            self.videoPreviewLayer?.frame = self.qrCodeView.layer.bounds
            self.qrCodeView.layer.addSublayer(self.videoPreviewLayer!)
            
            self.captureSession?.startRunning()
        }
    }
    @IBAction func onSkipButtonTapped(_ sender: Any) {
        self.popQR(isScaned: false)
    }
}

// MARK: - Internal
extension QRcodeViewController{
    func setupLabel(){
        if let _ = sourceDelegate {
            self.navigationItem.setHidesBackButton(true, animated: true)
            self.skiptBtn.setTitle(R.string.localizable.skip(), for: .normal)
            self.skiptBtn.setTitleColor(.black, for: .normal)
        }else{
            self.skiptBtn.isHidden = true
        }
        let attrs1 = [NSAttributedString.Key.font :APP_FONT_REGULAR, NSAttributedString.Key.foregroundColor :COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : APP_FONT_BOLD, NSAttributedString.Key.foregroundColor :COLOR_PRIMARY_TEXT]
        
        let attributedString1 = NSMutableAttributedString(string:R.string.localizable.getYour(), attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: "\n \(R.string.localizable.online_order())", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        
        self.rewardTitleLabel.attributedText = attributedString1
        self.rewardTitleLabel.setLineSpacing(lineSpacing: 0.5)
        self.rewardTitleLabel.textAlignment = .center
        
        self.qrMessageTitle.text = R.string.localizable.place_QR()
            
        
    }
    func clearQRCodeView() {
        self.presentCamera()

    }
    public func bindingData() {
        if let viewModel = viewModel {
            viewModel.onError = { [weak self] error in
                self?.showMessage(andMessage: error)
                self?.clearQRCodeView()
                
            }
            viewModel.onSuccessReadQRCode = { [weak self]  in
                self?.showToast(R.string.localizable.success_update_address())
                self?.popQR(isScaned: true)
            }
        }
    }
    func popQR(isScaned: Bool) {
        doOnMain(deadline: 1.0, {
            if let _ = self.sourceDelegate {
                self.onDismissQRVC!(isScaned)
            }
            self.navigationController?.popViewController()
        })
    }
}

// MARK: - AVFoundation Functions
extension QRcodeViewController{
   
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 {
            print("No QrCode Found")
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if supportedBarCodes.contains(metadataObj.type) {
            self.captureSession?.stopRunning()
            
//            let deleteAction =  UIAlertAction(title: R.string.localizable.ok(), style: .default) { (dialog) in
//
//            }
//                
//
//            
//            let fullAddressArr = metadataObj.stringValue?.components(separatedBy: ",") ?? []
//            if fullAddressArr.count > 0 {
//                let areaId  = fullAddressArr[1]
//                let cityId = fullAddressArr[2]
//                let streetName = fullAddressArr[0]
//                
//                UserDefaults.currentArea = SearchItemDTO(id:areaId,name:areaId)
//                UserDefaults.currentCity = SearchItemDTO(id:cityId,name:cityId)
//                UserDefaults.streetName = streetName
//                
////                self.showAlert(withTitle: metadataObj.stringValue!, andMessage: "area id = \(areaId) & city id = \(cityId) & strret name = \(streetName)" , withActions: [deleteAction], withCancel: true)
//
//                
//            }
            
        }
        self.viewModel?.saveAddressInfo( metadataObj.stringValue!)
        }
    
}
