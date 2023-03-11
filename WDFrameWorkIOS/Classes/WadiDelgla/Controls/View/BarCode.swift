//
//  BarCode.swift
//  Auntie Annes
//
//  Created by SimpleTouch on 6/11/19.
//  Copyright © 2019 Mohammed Habib. All rights reserved.
//

import UIKit
extension UIImage {
    
    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }
}
extension String {
      func generateBarcodeNumber() -> String {
        var  barcodeBuilder = self
        let loopCount = 13 - barcodeBuilder.count
        for _ in 0..<loopCount{
            barcodeBuilder.insert("0", at: barcodeBuilder.startIndex)
        }
        return barcodeBuilder
    }
}
